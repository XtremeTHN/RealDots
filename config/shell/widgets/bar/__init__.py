from widgets.bar.hypr import Workspace, ActiveWindow
from widgets.bar.quickicons import NetworkIndicator
from lib.utils import Box

from gi.repository import Gtk, Astal

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
        self.network_indicator = NetworkIndicator()
        self.right_box.append(self.network_indicator)

        self.set_start_widget(self.left_box)
        self.set_end_widget(self.right_box)

class Bar(Astal.Window):
    def __init__(self, m):
        super().__init__(gdkmonitor=m, namespace="topbar", css_classes=["bar-window"], anchor=Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT, exclusivity=Astal.Exclusivity.EXCLUSIVE)
        self.set_child(BarContent())

        self.present()