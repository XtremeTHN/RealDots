from gi.repository import Gtk, GObject, AstalWp, AstalBattery
from lib.logger import getLogger
from lib.network import NWrapper

def convert_to_percent(_, value):
    return f"{int(value * 100)}%"

class NetworkIndicator(Gtk.Image):
    def __init__(self, size=14, _class=[], bind_ssid=True):
        super().__init__(pixel_size=size, css_classes=_class)
        self.net = NWrapper.get_default()
        self.bind_ssid = bind_ssid

        self.net.bind_property("icon-name", self, "icon-name", GObject.BindingFlags.SYNC_CREATE)
        if self.bind_ssid is True:
            self.net.bind_property("ssid", self, "tooltip-text", GObject.BindingFlags.SYNC_CREATE)    
        
class VolumeIndicator(Gtk.Image):
    def __init__(self, size=14, _class=[], bind_volume=True):
        super().__init__(pixel_size=size, css_classes=_class)
        self.wayplumber = AstalWp.get_default()
        self.bind_volume = bind_volume

        self.speaker = None
        self.wayplumber.connect('notify::default-speaker', self.on_speaker_change)
        self.on_speaker_change(None, None)
    
    def on_speaker_change(self, _, __):
        self.speaker = self.wayplumber.get_default_speaker()
        if self.speaker is None:
            self.icon_name = "audio-volume-muted-symbolic"
            return
        if self.bind_volume is True:
            self.speaker.bind_property("volume-icon", self, "icon-name", GObject.BindingFlags.SYNC_CREATE)
        self.speaker.bind_property("volume", self, "tooltip-text", GObject.BindingFlags.SYNC_CREATE, transform_to=convert_to_percent)

class BatteryIndicator(Gtk.Image):
    def __init__(self, size=14, _class=[], bind_percentage=True):
        super().__init__(pixel_size=size, css_classes=_class)
        self.logger = getLogger("BatteryIndicator")

        self.battery = AstalBattery.get_default()
        if self.battery.get_power_supply() is False:
            self.logger.info("No battery found")
            self.set_visible(False)
            return
        
        if bind_percentage is True:
            self.battery.bind_property("percentage", self, "tooltip-text", GObject.BindingFlags.SYNC_CREATE, transform_to=convert_to_percent)
        self.battery.bind_property("icon-name", self, "icon-name", GObject.BindingFlags.SYNC_CREATE)


# class BluetoothIndicator(Gtk.Image)