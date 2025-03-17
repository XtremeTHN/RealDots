from gi.repository import Gtk, GObject, AstalNetwork
from lib.utils import Box
from widgets.quick.icons import NetworkIndicator, BatteryIndicator

class QuickButton(Gtk.Overlay):
    def __init__(self, icon, header, default_subtitle):
        super().__init__()

        self.button = Gtk.ToggleButton(css_classes=["quickbutton"])
        self.right_button = Gtk.Button(css_classes=["quickbutton-right"], halign=Gtk.Align.END, icon_name="go-next-symbolic")

        self.content = Box(spacing=10)
        self._label_box = Box(spacing=0, vertical=True)
        self.heading = Gtk.Label(label=header, xalign=0, css_classes=["quickbutton-heading"])
        self.subtitle = Gtk.Label(label=default_subtitle, xalign=0, css_classes=["quickbutton-subtitle"])

        self._label_box.append_all([self.heading, self.subtitle])
        self.content.append_all([icon, self._label_box])

        self.button.set_child(self.content)

        self.set_child(self.button)
        self.add_overlay(self.right_button)
        self.set_measure_overlay(self.right_button, True)

class QuickNetwork(QuickButton):
    def __init__(self):
        self.net_icon = NetworkIndicator(size=24, bind_ssid=False)
        self.wrapper = self.net_icon.net
        super().__init__(icon=self.net_icon, header="Internet", default_subtitle="Connected")
        self.wrapper.connect("notify::ssid", self.__change_title)
        # self.net.bind_property("ssid", self.subtitle, "label", flags=GObject.BindingFlags.SYNC_CREATE)
    
    def __change_title(self, *_):
        match self.wrapper.net.get_state():
            case AstalNetwork.DeviceState.DEACTIVATING:
                self.subtitle.set_label("Deactivating...")
            case AstalNetwork.DeviceState.DISCONNECTED:
                self.subtitle.set_label("Disconnected")
                self.set_active(False)
            case _:
                self.subtitle.set_label(self.wrapper.ssid)