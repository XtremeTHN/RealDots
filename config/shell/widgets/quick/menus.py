from gi.repository import Gtk, Adw, AstalNetwork
from lib.network import NWrapper
from lib.utils import Box

class StatusPage(Box):
    def __init__(self, title=None, description=None, icon=None):
        super().__init__(vertical=True)
        self.__title = Gtk.Label(label=title, css_classes=["title-3"])
        self.__description = Gtk.Label(label=description, css_classes=["dimmed"])
        self.__icon = Gtk.Image(icon_name=icon, pixel_size=28)

        self.append_all([self.__icon, self.__title, self.__description])
    
    def set_title(self, title):
        self.__title.set_label(title)
    
    def set_description(self, desc):
        self.__description.set_label(desc)
    
    def set_icon_name(self, icon_name):
        self.__icon.set_from_icon_name(icon_name)

class WifiButton(Gtk.Button):
    def __init__(self, access_point: AstalNetwork.AccessPoint, active_ssid: str):
        super().__init__()
        ssid = access_point.get_ssid() or "Unknown"
        self.content = Box(spacing=10, hexpand=True)
        self.icon = Gtk.Image(pixel_size=8,icon_name=access_point.get_icon_name())
        self.name = Gtk.Label(label=ssid)
        self._connected = Gtk.Image(icon_name="emblem-ok-symbolic", pixel_size=8, \
                                    halign=Gtk.Align.END, visible=active_ssid == access_point.get_ssid())

        self.content.append_all([self.icon, self.name, self._connected])

        self.set_child(self.content)
        self.connect("clicked", self.__on_clicked)
    
    def __on_clicked(self):
        ...

class QuickNetworkMenu(Adw.Bin):
    def __init__(self):
        super().__init__()
        # ugly code
        self.clamp = Adw.Clamp(maximum_size=200, orientation=Gtk.Orientation.VERTICAL)
        self.scrollable = Gtk.ScrolledWindow(css_classes=["quick-network-menu", "card"])
        self.content = Box(vertical=True, spacing=5, )
        self.wrapper = NWrapper.get_default()
        self.placeholder = StatusPage()

        self.wrapper.connect("changed", self.__on_wrapper_change); self.__on_wrapper_change(None)
        self.content.connect("notify::children", self.__on_children_change); self.__on_children_change()

        # ugly code
        self.content.append(self.placeholder)
        self.scrollable.set_child(self.content)
        self.clamp.set_child(self.scrollable)
        self.set_child(self.clamp)

    def __on_children_change(self, *_):
        if len(self.content.children) == 0:
            self.show_zero_wifi_placeholder()
        else:
            self.placeholder.set_visible(False)

    def __on_wrapper_change(self, _):
        if self.wrapper.is_wired():
            self.show_no_wifi_device_placeholder()
        else:
            self.wrapper.wifi.scan()
            self.wrapper.wifi.connect("notify::access-points", self.__on_access_points_changed); self.__on_access_points_changed()
            self.placeholder.set_visible(False)
        
    def __on_access_points_changed(self, *_):
        # access_points = map(lambda a: WifiButton(a, self.wrapper.ssid), self.wrapper.wifi.get_access_points())
        w = [WifiButton(a, self.wrapper.ssid) for a in self.wrapper.wifi.get_access_points()]
        self.content.clear()

        self.content.append_all(w)

    def show_zero_wifi_placeholder(self):
        self.placeholder.set_title("No wifi nearby")
        self.placeholder.set_description("No wifi devices to connect")
        self.placeholder.set_icon_name("network-wireless-no-route-symbolic")
        self.placeholder.set_visible(True)
    
    def show_no_wifi_device_placeholder(self):
        self.placeholder.set_title("No wifi device")
        self.placeholder.set_description("No wifi devices available. Connect a wifi dongle")
        self.placeholder.set_icon_name("network-wireless-disabled-symbolic")
        self.placeholder.set_visible(True)