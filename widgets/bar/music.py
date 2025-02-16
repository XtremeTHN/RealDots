from gi.repository import AstalMpris, Gtk, Gdk
from lib.config import Config

class MusicViewer():
    def __init__(self, window):
        self.box = window.center_box

        self.config_player = Config.get_default().player
        self.mpris_player = AstalMpris.Player.new("spotube" if self.config_player.value is None else self.config_player.value) 
        self.config_player.on_change(self.change_player)
            
        self.track_title = window.track_title
        self.track_progress = window.track_progress
        self.cover_art = window.cover_art

        self.mpris_player.connect("notify::position", self.on_update)
        self.mpris_player.connect("notify::title", self.on_track_changed)
        self.on_track_changed(None, None)
    
    def change_player(self, _):
        self.mpris_player = AstalMpris.Player.new(self.config_player.value)
        print("changing player to ", self.config_player.value)
    
    def on_track_changed(self, _, _p):
        try:
            texture = Gdk.Texture.new_from_filename(self.mpris_player.props.cover_art)
        except Exception as e:
            print("music: couldn't create texture from file:", self.mpris_player.props.cover_art, "\nerror:", e)
            self.cover_art.set_paintable(Gdk.Texture.new_empty(0,0))
        
        self.cover_art.set_paintable(texture)
    
    def on_update(self, _, _p):
        self.track_title.set_label(f'{self.mpris_player.props.title} - {self.mpris_player.props.artist}')
        self.track_progress.set_label(f'<span size="xx-small">{self.mpris_player.props.position}</span>')