from gi.repository import GObject, GObject, AstalWp
from lib.utils import Object

class WpWrapper(Object):
    icon_name = GObject.Property(type=str, default="audio-volume-high-symbolic", nick="icon-name")
    volume = GObject.Property(type=str, default="0%", nick="tooltip-text")
    def __init__(self):
        super().__init__()
        self.wp = AstalWp.get_default()
        self.speaker = self.wp.get_default_speaker()
        self.__icon_binding = None
        self.__vol_binding = None

        self.on_speaker_change(None, None)
        self.wp.connect('notify::default-speaker', self.on_speaker_change)

    def on_speaker_change(self, _, __):
        self.speaker = self.wp.get_default_speaker()
        if self.__icon_binding is not None:
            self.__icon_binding.unbind()
        if self.__vol_binding is not None:
            self.__vol_binding.unbind()

        if self.speaker is not None:
            self.__icon_binding = self.speaker.bind_property("volume-icon", self, "icon-name", GObject.BindingFlags.SYNC_CREATE)
            self.__vol_binding = self.speaker.bind_property("volume", self, "volume", GObject.BindingFlags.SYNC_CREATE, transform_to=lambda _,v: f"{int(v * 100)}%")
        else:
            self.icon_name = "audio-volume-muted-symbolic"
            self.volume = "0% (No device)"