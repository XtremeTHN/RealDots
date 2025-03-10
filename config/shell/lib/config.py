from lib.constants import JSON_CONFIG_PATH
from lib.services.opt import Json
from lib.utils import Object

class Config(Object):
    def __init__(self):
        self.conf = Json(JSON_CONFIG_PATH)
        self.conf.start()

        self.wallpaper = self.conf.get_opt("background.wallpaper")

        self.fallback_window_name = self.conf.get_opt("bar.active-window.fallback-name", default="ArchLinux")
        self.player = self.conf.get_opt("bar.music-player")


