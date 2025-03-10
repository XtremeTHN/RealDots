from gi.repository import AstalMpris, Gtk, GLib
from lib.logger import getLogger
from lib.config import Config

def to_minutes(seconds):
    seconds = int(seconds)
    minutes = seconds // 60
    seconds = seconds % 60
    return f"{minutes:02d}:{seconds:02d}"

class Music(Gtk.Box):
    def __init__(self, _class=[]):
        super().__init__(css_classes=_class)
        self.mpris = AstalMpris.get_default()
        self.mpris.get_players()

        self.music_info = Gtk.Label()
        self.append(self.music_info)
        
        self.__pos_id = None
        self.__title_id = None
        self.__length_id = None
        self.player = None

        self.mpris.connect('notify', self.__info_changed)
        self.mpris.connect('player-added', self.__on_player_added)
        self.mpris.connect('player-closed', self.__on_player_removed)
        self.__select_last_player()

    def __select_last_player(self):
        print(self.mpris.get_players())
        if len(self.mpris.get_players()) > 0:
            self.__on_player_added(None, self.mpris.get_players()[-1])
        else:
            self.set_visible(False)
    
    def __on_player_removed(self, _, player: AstalMpris.Player):
        print(player, "removed", self.player)
        print(player == self.player, self.player is player)
        if self.player is player:
            self.__disconnect()
            self.player = None
            self.__select_last_player()
    
    def __disconnect(self):
        self.player.disconnect(self.__pos_id)
        self.player.disconnect(self.__title_id)
        self.player.disconnect(self.__length_id)
    
    def __on_player_added(self, _, player: AstalMpris.Player):
        if self.player is not None:
            self.__disconnect()

        self.player = player
        self.__pos_id = self.player.connect('notify::position', self.__info_changed)
        self.__title_id = self.player.connect('notify::title', self.__info_changed)
        self.__length_id = self.player.connect('notify::length', self.__info_changed)

    def __info_changed(self, _, __):
        GLib.idle_add(self.music_info.set_text, f"{self.player.get_title()} - {self.player.get_artist()} {to_minutes(self.player.get_position())}/{to_minutes(self.player.get_length())}")