from gi.repository import AstalHyprland, Gtk, Pango
from lib.utils import Box

# class ActiveWindowInfo(Box):
#     def __init__(self):
#         super().__init__(css_classes=["bar-container"], spacing=0, vertical=True)

#         self.window_name = Gtk.Label(css_classes=["window-class"])
#         self.window_class = Gtk.Label(css_classes=["window-class"], use_markup=True)

#         self.append_all([self.window_name, self.window_class])

#         self.hypr = AstalHyprland.get_default()
#         self.hypr.connect('notify::focused-client', self.on_window_change)
    
#     def on_window_change(self, _, __):
#         win = self.hypr.get_focused_client()
#         self.window_name.set_text(win.get_title())
#         self.window_class.set_text(win.get_class())

class ActiveWindow(Gtk.Label):
    def __init__(self):
        super().__init__(css_classes=["bar-container"], max_width_chars=30, ellipsize=Pango.EllipsizeMode.END)
        self.hypr = AstalHyprland.get_default()
        self.hypr.connect('notify::focused-client', self.on_window_change)
    
    def on_window_change(self, _, __):
        win = self.hypr.get_focused_client()
        if win is not None:
            self.set_text(win.get_title())


class Workspace(Gtk.Box):
    def __init__(self, id):
        super().__init__(css_classes=["workspace"], valign=Gtk.Align.CENTER)
        self.id = id

    def set_active(self, active):
        if active is False:
            self.remove_css_class("active")
        else:
            self.add_css_class("active")

class Workspaces(Gtk.Box):
    def __init__(self):
        super().__init__(css_classes=["bar-container"], spacing=5)
        self.hypr = AstalHyprland.get_default()
        self.hypr.connect('notify::focused-workspace', self.on_workspace_change)
        self.children = []
        for w in range(1,6):
            _w = Workspace(w)
            self.append(_w)
            self.children.append(_w)

    def on_workspace_change(self, _, __):
        for w in self.children:
            if w.id == self.hypr.get_focused_workspace().get_id():
                w.set_active(True)
            else:
                w.set_active(False)