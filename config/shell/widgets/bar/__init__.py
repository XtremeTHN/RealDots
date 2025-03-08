from widgets.bar.hypr import Workspace, ActiveWindow
from widgets.bar.quickicons import NetworkIndicator
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
        self.date_widget = Gtk.Label(css_classes=["bar-container"])
        self.network_indicator = NetworkIndicator(_class=["bar-container"])

        self.right_box.append_all([self.date_widget, self.network_indicator])

        self.set_start_widget(self.left_box)
        self.set_end_widget(self.right_box)

        # Tasks
        self.__date = LoopTask(self.__update_date, 1)
        self.__date.start()

        # Connections
        # self.__date.connect("changed", self.date_widget.)
    
    def __update_date(self):
        self.date_widget.set_label(GLib.DateTime.new_now_local().format("%I:%M %p %b %Y"))

class Bar(Astal.Window):
    def __init__(self, m):
        super().__init__(gdkmonitor=m, namespace="topbar", css_classes=["bar-window"], anchor=Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT, exclusivity=Astal.Exclusivity.EXCLUSIVE)
        self.set_child(BarContent())

        self.present()