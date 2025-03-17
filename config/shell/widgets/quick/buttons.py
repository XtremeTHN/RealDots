from gi.repository import Gtk, GObject, AstalNetwork
from lib.utils import Box
from widgets.quick.icons import NetworkIndicator, BatteryIndicator

class QuickButton(Gtk.Overlay):
    def __init__(self, icon, header, default_subtitle):
        super().__init__()

        self.button = Gtk.Button(css_classes=["quickbutton"])
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
        self.wrapper.net.connect("notify::state", self.__change_subtitle); self.__change_subtitle()
        self.wrapper.connect("notify::ssid", self.__change_title); self.__change_title()
    
    def set_active(self, active):
        if active is True:
            # self.button.set_active(True)
            self.button.add_css_class("active")
        else:
            # self.button.set_active(False)
            self.button.remove_css_class("active")
    
    def __change_title(self, *_):
        if self.wrapper.is_wifi():
            self.heading.set_label(self.wrapper.ssid)
        else:
            self.heading.set_label("Internet")

    def __change_subtitle(self, *_):
        match self.wrapper.net.get_state():
            case AstalNetwork.State.DISCONNECTING:
                self.subtitle.set_label("Disconnecting...")
            case AstalNetwork.State.DISCONNECTED:
                self.subtitle.set_label("Disconnected")
                self.set_active(False)
            case _:
                self.subtitle.set_label(self.wrapper.ssid)
                self.set_active(True)