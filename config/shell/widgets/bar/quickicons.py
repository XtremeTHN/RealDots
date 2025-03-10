from gi.repository import Gtk, GObject, AstalWp
from lib.network import NWrapper

class NetworkIndicator(Gtk.Image):
    def __init__(self, _class=[]):
        super().__init__(pixel_size=14, css_classes=_class)
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
    
class VolumeIndicator(Gtk.Image):
    def __init__(self, _class=[]):
        super().__init__(pixel_size=14, css_classes=_class)
        self.wayplumber = AstalWp.get_default()
        self.speaker = None

        self.wayplumber.connect('notify::default-speaker', self.on_speaker_change)
        self.on_speaker_change(None, None)
    
    def on_speaker_change(self, _, __):
        self.speaker = self.wayplumber.get_default_speaker()
        if self.speaker is None:
            self.icon_name = "audio-volume-muted-symbolic"
            return
        
        self.speaker.bind_property("volume-icon", self, "icon-name", GObject.BindingFlags.SYNC_CREATE)
        self.speaker.bind_property("volume", self, "tooltip-text", GObject.BindingFlags.SYNC_CREATE, transform_to=lambda _,v: f"{int(v * 100)}%")


# class BluetoothIndicator(Gtk.Image)