from gi.repository import Astal, Gtk, Adw, Gdk, GLib
from lib.config import Config
from lib.variable import Variable
from lib.constants import CONFIG_DIR

from widgets.bar.workspaces import Workspaces

conf = Config.get_default()

@Gtk.Template(filename=str(CONFIG_DIR / "res/ui/bar.ui"))
class Bar(Astal.Window):
    __gtype_name__ = "Bar"
    
    start_box: Gtk.Box = Gtk.Template.Child()
    pfp: Adw.Avatar = Gtk.Template.Child()
    hostname: Gtk.Label = Gtk.Template.Child()
    time: Gtk.Label = Gtk.Template.Child()
    def __init__(self, m):
        super().__init__(gdkmonitor=m, anchor=Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT)
        self.time_var = Variable("").poll(1000, self.update_time)

        conf.profile_picture.on_change(self.change_pfp, once=True)
        conf.hostname.on_change(self.change_hostname, once=True)

        self.start_box.append(Workspaces())

        self.present()
    
    def update_time(self):
        self.time.set_label(GLib.DateTime.new_now_local().format("%I:%M %p %b %Y"))

    def change_hostname(self, _):
        if conf.hostname.is_set():
            self.hostname.set_text(conf.hostname.value)
        else:
            # Default host
            self.hostname.set_text("Linux")

    def change_pfp(self, _):
        if conf.profile_picture.is_set():
            try:
                img = Gdk.Texture.new_from_filename(conf.profile_picture.value)
            except Exception as e:
                print("couldn't create texture from file:", conf.profile_picture.value, "\nerror:", e)
                return
            self.pfp.set_custom_image(img)