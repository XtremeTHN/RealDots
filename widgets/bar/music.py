from gi.repository import AstalMpris, Gtk
from lib.config import Config

class MusicViewer(Gtk.Box):
    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL)
        self.config_player = Config.get_default().player
        self.mpris_player = AstalMpris.Player.new("spotube" if self.config_player.value is None else self.config_player.value) 
        self.conf.player.on_change(self.change_player)
            
        self.track_title = Gtk.Label()
        self.track_progress = Gtk.Label()
        self.track_progress.add_css_class("music-progress")
    
    def change_player(self, _):
        self.mpris_player = AstalMpris.Player.new(self.config_player.value)
    
