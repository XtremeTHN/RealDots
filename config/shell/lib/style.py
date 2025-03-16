import subprocess

from lib.constants import CONFIG_DIR
from gi.repository import Gio

class Style:
    STYLES_DIR = CONFIG_DIR / "style"
    def compile_scss():
        try:
            subprocess.check_call(["sass", str(Style.STYLES_DIR / "main.scss"), str(Style.STYLES_DIR / "style.css")], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        except Exception as e:
            print(e)
            return
        
    def watcher(cb):
        ...