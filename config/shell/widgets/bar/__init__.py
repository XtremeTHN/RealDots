from widgets.quick.icons import NetworkIndicator, VolumeIndicator, BatteryIndicator
from widgets.bar.hypr import Workspace, ActiveWindow
from widgets.bar.music import Music
from lib.task import LoopTask
from lib.utils import Box

from gi.repository import Gtk, Astal, GLib

class BarContent(Gtk.CenterBox):
    def __init__(self):
        super().__init__(css_classes=["bar"], orientation=Gtk.Orientation.HORIZONTAL)

        # Left side
        self.left_box = Box(spacing=10)
        self.workspaces = Workspace(_class=["bar-container"])
        self.active_window = ActiveWindow(_class=["bar-container"])
        self.left_box.append_all([self.workspaces, self.active_window])

        # Right side
        self.right_box = Box(spacing=10)

        self.music = Music(_class=["bar-container"])
        self.date_widget = Gtk.Label(css_classes=["bar-container"])
        
        self.quickicons = Box(spacing=10, css_classes=["bar-container"])
        self.network_indicator = NetworkIndicator()
        self.volume_indicator = VolumeIndicator()
        self.battery_indicator = BatteryIndicator()

        self.quickicons.append_all([self.network_indicator, self.volume_indicator, self.battery_indicator])
        self.right_box.append_all([self.music, self.date_widget, self.quickicons])

        self.set_start_widget(self.left_box)
        self.set_end_widget(self.right_box)

        # Tasks
        GLib.timeout_add(1000, self.__update_date)

        # Connections
        # self.__date.connect("changed", self.date_widget.)
    
    def __update_date(self, *_):
        GLib.idle_add(self.date_widget.set_label, GLib.DateTime.new_now_local().format("%I:%M %p %b %Y"))
        return True

class Bar(Astal.Window):
    def __init__(self, m):
        super().__init__(gdkmonitor=m, namespace="topbar", css_classes=["bar-window"], anchor=Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT, exclusivity=Astal.Exclusivity.EXCLUSIVE)
        self.set_child(BarContent())

        self.present()