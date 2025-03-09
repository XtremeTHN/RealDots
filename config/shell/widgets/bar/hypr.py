from gi.repository import AstalHyprland, Gtk, Pango
from lib.config import Config
from lib.utils import Box

class ActiveWindow(Gtk.Label):
    def __init__(self, _class=[]):
        super().__init__(css_classes=_class,  max_width_chars=30, ellipsize=Pango.EllipsizeMode.END)
        self.hypr = AstalHyprland.get_default()
        self.conf = Config.get_default()
        self.fallback_name = self.conf.fallback_window_name.value

        self.conf.fallback_window_name.on_change(self.__change_fallback_name)
        self.hypr.connect('event', self.__on_event)
        self.hypr.connect('notify::focused-client', self.__on_window_change); self.__on_window_change(None, None)
    
    def __change_fallback_name(self, _):
        self.fallback_name = self.conf.fallback_window_name.value
    
    def __on_event(self, _, event, args):
        if event == "windowtitle" or event == "windowtitlev2":
            self.__on_window_change(None, None)
    
    def __on_window_change(self, _, __):
        win = self.hypr.get_focused_client()
        if win is not None:
            self.set_text(win.get_title())
        else:
            self.set_text(self.fallback_name)

class Workspace(Gtk.Label):
    def __init__(self, _class=[]):
        super().__init__(css_classes=_class)
        self.hypr = AstalHyprland.get_default()
        self.hypr.connect('notify::focused-workspace', self.on_workspace_change); self.on_workspace_change(None, None)

    def on_workspace_change(self, _, __):
        if self.hypr.get_focused_workspace() is None:
            self.set_text("Workspace Unknown")
        else:
            self.set_text(f"Workspace {self.hypr.get_focused_workspace().get_id()}")
