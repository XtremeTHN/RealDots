from ctypes import CDLL
CDLL('libgtk4-layer-shell.so')

import gi
def __require_astal_feats(feature: str | list[str], version="0.1"):
    if isinstance(feature, str):
        feature = [feature]
    for x in feature:
        gi.require_version(f"Astal{x}", version)

gi.require_versions({
    "Astal": "4.0",
    "Adw": "1"
})

__require_astal_feats(["IO", "Hyprland", "Network", "Wp",\
                       "Battery", "Mpris",])