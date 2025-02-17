from gi.repository import Gtk, GObject
from lib.network import NWrapper
from lib.audio import WpWrapper

class NetworkIndicator(Gtk.Image):
    def __init__(self):
        super().__init__()
        self.net = NWrapper.get_default()

        self.__icon_binding = None
        self.__ssid_binding = None

        self.on_icon_change(None, None)
        self.on_ssid_change(None, None)
    
    def on_icon_change(self, _, __):
        if self.__icon_binding is not None:
            self.__icon_binding.unbind()
        self.net.bind_property("icon-name", self, "icon-name", GObject.BindingFlags.SYNC_CREATE)
    
    def on_ssid_change(self, _, __):
        if self.__ssid_binding is not None:
            self.__ssid_binding.unbind()
        self.net.bind_property("ssid", self, "tooltip-text", GObject.BindingFlags.SYNC_CREATE)

class AudioIndicator(Gtk.Image):
    def __init__(self):
        super().__init__()
        self.wp = WpWrapper.get_default()

        self.wp.bind_property("icon-name", self, "icon-name", GObject.BindingFlags.SYNC_CREATE)
        self.wp.bind_property("volume", self, "tooltip-text", GObject.BindingFlags.SYNC_CREATE)