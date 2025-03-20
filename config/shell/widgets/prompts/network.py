from gi.repository import Gtk, Adw, Astal, AstalNetwork
from lib.network import NWrapper
from lib.utils import Box

class Background(Astal.Window):
    def __init__(self):
        super().__init__(namespace="background", \
                         anchor=Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT,\
                         layer=Astal.Layer.OVERLAY, css_classes=["background-window"])
        
class Spinner(Box):
    def __init__(self, description=None):
        super().__init__(vertical=True, spacing=10)
        self.desc = Gtk.Label.new(description)
        self.spinner = Adw.Spinner.new()
        self.append_all([self.desc, self.spinner])

class ErrorPage(Adw.NavigationPage):
    def __init__(self, msg, nav):
        super().__init__(tag="error-page")
        
        status = Adw.StatusPage(title="Couldn't connect", description=msg, icon_name="network-wireless-offline-symbolic")
        self.close_btt = Gtk.Button(label="Close")
        status.set_child(self.close_btt)

        self.close_btt.connect("clicked", lambda *_: nav.pop_by_tag("pass-page"))
        self.set_child(status)

class PasswordPage(Adw.NavigationPage):
    def __init__(self, ssid, nav):
        super().__init__(title="Password", tag="pass-page")
        self.nav = nav
        self.win: Astal.Window = nav.win

        self.content = Box(vertical=True, spacing=10)
        self.ssid = ssid
        description = Gtk.Label.new(f"Provide the password of {ssid}")
        
        self.password = Gtk.PasswordEntry(show_peek_icon=True)
        self.password.connect('activate', self.__on_enter)

        self.content.append_all([description, self.password])

    def __on_enter(self, _):
        self.nav.push_by_tag("progress")

        wrapper = NWrapper.get_default()
        wrapper.connect_to_ssid(self.ssid, self.password.get_text(), self.__on_success, self.__on_error)
    
    def __on_error(self, exc: Exception):
        page = ErrorPage(" ".join(exc))
        self.nav.push(page)
    
    def __on_success(self):
        self.win.close()
    
class ProgressPage(Adw.NavigationPage):
    def __init__(self):
        super().__init__(tag="progress")
        self.content = Box(vertical=True, spacing=4)
        self.spinner = Adw.Spinner.new()
        self.description = Gtk.Label.new("Connecting...")

        self.content.append_all([self.spinner, self.description])

class NetworkPromptNavigator(Adw.Bin):
    def __init__(self, win, ap: AstalNetwork.AccessPoint ):
        super().__init__()
        self.nav = Adw.NavigationView()
        self.win = win
        self.ap = ap

        password = PasswordPage(self.ap.get_ssid(), self)
        prog = ProgressPage()

        self.nav.add(password)
        self.nav.add(prog)
        self.set_child(self.nav)

class NetworkPrompt(Astal.Window):
    def __init__(self, access_point: AstalNetwork.AccessPoint):
        super().__init__(exclusivity=Astal.Exclusivity.NORMAL, keymode=Astal.Keymode.EXCLUSIVE,\
                         css_classes=["network-prompt"])
        
        self.background = Background()
        self.background.present()
        
        nav = NetworkPromptNavigator(self, access_point)
        self.content = Box(vertical=True)
        self.content.append(Gtk.Label.new("Network"))

        self.set_child(nav)
        self.present()
    
    def close(self):
        super().close()
        self.background.close()