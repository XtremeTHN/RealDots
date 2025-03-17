from gi.repository import Gtk, Astal, Gdk, GLib, Adw
from lib.logger import getLogger
from lib.config import Config
from lib.utils import Box

from widgets.quick.buttons import QuickNetwork

def get_pretty_seconds(seconds):
    dias = int(seconds // 86400)
    horas = int((seconds % 86400) // 3600)
    minutos = int((seconds % 3600) // 60)
    return dias, horas, minutos

class FramedImage(Gtk.Frame):
    def __init__(self, size: int, _class=[]):
        super().__init__(css_classes=["quickframe"])

        self.image = Gtk.Image(css_classes=_class, pixel_size=size)
        self.set_child(self.image)
    
    def set_paintable(self, paintable):
        self.image.set_from_paintable(paintable)
    
    def set_icon_name(self, icon_name):
        self.image.set_from_icon_name(icon_name)

class Uptime(Gtk.Label):
    def __init__(self):
        super().__init__(css_classes=["uptime"], xalign=0)
        self.config = Config.get_default()
        self.proc_uptime = open("/proc/uptime", 'r')
        self.logger = getLogger("Uptime")
        self.update()

    def update(self, *_, **__):
        cnt = self.proc_uptime.read().split(" ")
        self.proc_uptime.seek(0)
        time = get_pretty_seconds(float(cnt[0]))

        string = "up "
        if time[0] != 0:
            string += f"{time[0]} days,"
        elif time[1] != 0:
            string += f"{time[1]} hours,"
        elif time[2] != 0:
            string += f"{time[2]} minutes"
        
        if time[0] == 0 and time[1] == 0 and time[2] == 0:
            string += " less than a minute"
        self.set_label(string.strip(","))

class QuickSettingsContent(Box):
    def __init__(self, w):
        super().__init__(vertical=True, spacing=10, css_classes=["quicksettings-content"])
        self.config = Config.get_default()
        self.logger = getLogger("QuickSettings")

        # Top part of the window
        self.top = Box(spacing=10)
        self.label_box = Box(vertical=True, spacing=0, css_classes=["quick-labels"])

        self.pfp = Adw.Avatar(size=48)
        self.name = Gtk.Label(css_classes=["quick-name"], xalign=0)
        self.uptime = Uptime()
        
        self.label_box.append_all([self.name, self.uptime])
        self.top.append_all([self.pfp, self.label_box])

        # Center box
        self.center = Box(spacing=10, homogeneous=True)
        self.center.append(QuickNetwork())

        # Connections
        self.config.quick_username.on_change(self._update_name, once=True)
        self.config.profile_picture.on_change(self.__update_pfp, once=True)

        self.append_all([self.top, self.center])

    def _update_name(self, *_):
        if self.config.quick_username.is_set() is False:
            environ = GLib.get_environ()
            user = [var.split("=")[1] for var in environ if var.startswith("USER")]
            self.name.set_text(user[0].title())
        else:
            self.name.set_text(self.config.quick_username.value)
    
    def _update_uptime(self, *_):
        self.uptime.update()

    def __update_pfp(self, _):
        self.logger.debug("Changing profile picture...")
        self.logger.debug("Path: %s", self.config.profile_picture.value)
        if self.config.profile_picture.is_set():
            try:
                img = Gdk.Texture.new_from_filename(self.config.profile_picture.value)
                self.pfp.set_custom_image(img)
            except:
                self.logger.exception("Couldn't apply texture to Gtk.Picture")
                return
        else:
            self.pfp.set_icon_name("avatar-default-symbolic")

class QuickSettings(Astal.Window):
    def __init__(self, monitor):
        # Set resizable to false. When the quick menu shows, the window will go back to its original size
        super().__init__(namespace="quicksettings", name="quicksettings",\
                         gdkmonitor=monitor, \
                         anchor=Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT, \
                         exclusivity=Astal.Exclusivity.NORMAL, css_classes=["quicksettings-window"],\
                         resizable=False)

        self.content = QuickSettingsContent(self)
        self.set_child(self.content)

        self.connect("notify::visible", self.content._update_uptime)

        self.set_margin_top(10)
        self.set_margin_right(10)

        self.present()
