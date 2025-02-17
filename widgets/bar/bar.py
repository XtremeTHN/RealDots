from gi.repository import Gtk, Adw, Astal, GLib, Gdk

from lib.utils import Box
from lib.config import Config
from lib.logger import getLogger
from lib.variable import Variable
from widgets.bar.quickicons import NetworkIndicator
from widgets.bar.hypr import Workspaces, ActiveWindow

class Bar(Astal.Window):
    def __init__(self, mon):
        self.logger = getLogger("Bar")

        super().__init__(gdkmonitor=mon, anchor=Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT)
        self.add_css_class("bar")
        self.cfg = Config.get_default()

        self.root = Gtk.CenterBox(orientation=Gtk.Orientation.HORIZONTAL)
        self.time = Variable("")

        # Bar left side
        self._left_box = Box(spacing=10)
        self.profile_picture_widget = Adw.Avatar(size=30)
        self.window_info = ActiveWindow()

        self.workspaces_widget = Workspaces()
        self._left_box.append_all([self.profile_picture_widget, self.window_info, self.workspaces_widget])

        # Bar center
        # TODO: task bar

        # Bar right side
        self._right_box = Box(spacing=10)
        self.music_widget = Box()
        self.time_widget = Gtk.Label(css_classes=["bar-container"])
        self.control_button_widget = Gtk.Button(css_classes=["bar-container"])
        self.control_button_box = Box()
        self.control_button_widget.set_child(self.control_button_box)

        # TODO: implement bluetooth indicator
        self.bluetooth_icon = Gtk.Image.new_from_icon_name("bluetooth-disabled-symbolic")
        self.network_icon = NetworkIndicator()

        self.control_button_box.append_all([self.bluetooth_icon, self.network_icon])

        self._right_box.append_all([self.music_widget, self.time_widget, self.control_button_widget])

        self.root.set_start_widget(self._left_box)
        self.root.set_end_widget(self._right_box)

        # Connections
        self.cfg.profile_picture.on_change(self.change_pfp, once=True)
        self.time.poll(1000, self.update_time)
        
        self.set_child(self.root)

        self.present()
    
    def update_time(self):
        self.time_widget.set_label(GLib.DateTime.new_now_local().format("%I:%M %p %b %Y"))
    
    def change_hostname(self, _):
        self.logger.debug("Changing hostname...")
        self.logger.debug("Hostname: %s", self.cfg.hostname.value)
        if self.cfg.hostname.is_set():
            self.window_name_widget.set_text(self.cfg.hostname.value)
        else:
            # Default host
            self.window_name_widget.set_text("Linux")
    
    def change_pfp(self, _):
        self.logger.debug("Changing profile picture...")
        self.logger.debug("Path: %s", self.cfg.profile_picture.value)
        if self.cfg.profile_picture.is_set():
            try:
                img = Gdk.Texture.new_from_filename(self.cfg.profile_picture.value)
            except Exception as e:
                self.logger.error("Couldn't create texture from file: %s", self.cfg.profile_picture.value)
                self.logger.error("Error: %s", e)
                return
            self.profile_picture_widget.set_custom_image(img)