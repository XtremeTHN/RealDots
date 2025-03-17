from gi.repository import Gtk, Adw, AstalNetwork
from lib.network import NWrapper
from lib.utils import Box

class QuickNetworkMenu(Gtk.Revealer):
    def __init__(self):
        super().__init__(transition_type=Gtk.RevealerTransitionType.SLIDE_DOWN, transition_duration=600)
        self.wrapper = NWrapper.get_default()

        self.content = Box(vertical=True, spacing=10, css_classes=["quick-network-menu"])

        self.placeholder = Adw.StatusPage(css_classes=["compact"], icon_name="network-wireless-no-route-symbolic", title="No wifi nearby", subtitle="No wifi devices to connect")

        self.set_child(self.content)

    def show_zero_wifi_placeholder(self):
        self.placeholder.set_title("No wifi nearby")
        self.placeholder.set_subtitle("No wifi devices to connect")
        self.placeholder.set_icon_name("network-wireless-no-route-symbolic")
        