from gi.repository import Gtk, GObject, AstalNetwork, NM
from lib.utils import Box
from widgets.quick.icons import NetworkIndicator
from widgets.quick.menus import QuickNetworkMenu

class QuickButton(Box):
    def __init__(self, icon, header, default_subtitle):
        super().__init__(vertical=True)
        self.overlay = Gtk.Overlay.new()
        self.button = Gtk.Button(css_classes=["quickbutton"])
        self.right_button = Gtk.Button(css_classes=["quickbutton-right"], halign=Gtk.Align.END, icon_name="go-next-symbolic")

        self.button_content = Box(spacing=10)
        self._label_box = Box(spacing=0, vertical=True)
        self.heading = Gtk.Label(label=header, xalign=0, css_classes=["quickbutton-heading"])
        self.subtitle = Gtk.Label(label=default_subtitle, xalign=0, css_classes=["quickbutton-subtitle"])

        self.revealer = Gtk.Revealer(transition_type=Gtk.RevealerTransitionType.SLIDE_DOWN, transition_duration=600)

        self._label_box.append_all([self.heading, self.subtitle])
        self.button_content.append_all([icon, self._label_box])

        self.button.set_child(self.button_content)

        self.overlay.set_child(self.button)
        self.overlay.add_overlay(self.right_button)
        self.overlay.set_measure_overlay(self.right_button, True)

        self.right_button.connect("clicked", self.toggle_menu)
        
        self.append_all([self.overlay, self.revealer])
    
    def toggle_menu(self, *_):
        condition = not self.revealer.get_reveal_child()
        self.revealer.set_reveal_child(condition)
        if condition is True:
            self.button.add_css_class("menu")
            self.right_button.add_css_class("menu")
        else:
            self.right_button.remove_css_class("menu")
            self.button.remove_css_class("menu")
    
    def set_menu(self, menu):
        self.revealer.set_child(menu)
        self.menu = menu

class QuickNetwork(QuickButton):
    def __init__(self):
        self.net_icon = NetworkIndicator(size=24, bind_ssid=False)
        self.wrapper = self.net_icon.net
        super().__init__(icon=self.net_icon, header="Internet", default_subtitle="Connected")
        self.wrapper.net.connect("notify::state", self.__change_subtitle); self.__change_subtitle()
        self.wrapper.connect("notify::ssid", self.__change_title); self.__change_title()

        self.button.connect("clicked", self.toggle)

        self.set_menu(QuickNetworkMenu())

        self.active = False
    
    def set_active(self, active):
        if active is True:
            self.active = True
            if self.wrapper.is_wifi() is True:
                self.wrapper.wifi.set_enabled(True)
            self.button.add_css_class("active")
        else:
            self.active = False
            if self.wrapper.is_wifi() is True:
                self.wrapper.wifi.set_enabled(False)
            self.button.remove_css_class("active")
    
    def toggle(self, *_):
        self.set_active(not self.active)
    
    def __change_title(self, *_, force=False):
        if force is True or self.wrapper.is_wired():
            self.heading.set_label("Internet")
        else:
            self.heading.set_label(self.wrapper.ssid)

    def __change_subtitle(self, *_):
        match self.wrapper.net.get_state():
            case AstalNetwork.State.DISCONNECTING:
                self.subtitle.set_label("Disconnecting...")
            case AstalNetwork.State.DISCONNECTED:
                self.subtitle.set_label("Disconnected")
                self.__change_title(force=True)
                self.set_active(False)
            case AstalNetwork.State.CONNECTED_GLOBAL:
                self.subtitle.set_label("Connected")
                self.__change_title()
                self.set_active(True)
            case AstalNetwork.State.CONNECTING | AstalNetwork.State.CONNECTED_SITE | AstalNetwork.State.CONNECTED_LOCAL:
                self.subtitle.set_label("Connecting...")
            case _:
                self.subtitle.set_label(f"Unknown state")