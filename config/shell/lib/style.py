import subprocess

from lib.utils import Watcher
from lib.constants import CONFIG_DIR

class Style:
    STYLES_DIR = CONFIG_DIR / "style"
    def compile_scss():
        try:
            subprocess.check_call(["sass", str(Style.STYLES_DIR / "scss" / "main.scss"), str(Style.STYLES_DIR / "style.css")], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        except Exception as e:
            print(e)
            return
        
    def watcher(cb):
        w = Watcher()
        w.add_watch(str(Style.STYLES_DIR / "scss"))
        w.add_watch(str(Style.STYLES_DIR / "scss" / "widgets"))
        w.connect("event", cb)
        w.start()