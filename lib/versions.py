import gi
from ctypes import CDLL
CDLL('libgtk4-layer-shell.so')

gi.require_versions({
    "AstalHyprland": "0.1",
    "Astal": "4.0",
    "AstalMpris": "0.1",
    "Adw": "1",
    "Gtk": "4.0"
})

from gi.repository import Adw
Adw.init()