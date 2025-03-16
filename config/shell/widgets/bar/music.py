from gi.repository import AstalMpris, Gtk, GLib
from lib.logger import getLogger
from lib.config import Config

def to_minutes(seconds):
    seconds = int(seconds)
    minutes = seconds // 60
    seconds = seconds % 60
    return f"{minutes:02d}:{seconds:02d}"

# CONECTANDO COSAS
class Music(Gtk.Label):
    def __init__(self, _class=[]):
        super().__init__(css_classes=_class)
        self.config = Config.get_default()
        self.logger = getLogger("Music")

        self._config_player = self.config.player.value
        self.config.player.on_change(self.__change_player)

        self.player = AstalMpris.Player.new(self._config_player)
        self.__change_visible(None, None)
        self.player.connect("notify::available", self.__change_visible)
        self.player.connect("notify", self.__update_info)

    def __update_info(self, _, __):
        self.set_text(f"{self.player.get_title()} - {to_minutes(self.player.get_position())} / {to_minutes(self.player.get_length())}")

    def __change_visible(self, _, __):
        if self.player.get_available() is False:
            self.logger.info(f"{self._config_player} disappeared")
            self.set_visible(False)
            self.set_text("")
        else:
            self.logger.info(f"{self._config_player} appeared")
            self.set_visible(True)
        
        return self.player.get_available()

    def __change_player(self, _):
        self._config_player = self.config.player.value
        self.logger.info("Changing player to %s...", self._config_player)
        self.player = AstalMpris.Player.new(self._config_player)