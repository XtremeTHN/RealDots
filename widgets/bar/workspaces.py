from gi.repository import AstalHyprland, Gtk

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