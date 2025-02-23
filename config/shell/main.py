import lib.versions
import sys

from gi.repository import Astal, AstalIO, Gio

from lib.task import Task
from lib.config import Config
from widgets.bar.bar import Bar
from lib.style import compile_scss
from lib.constants import CONFIG_DIR
from lib.logger import getLogger

class ShellApp(Astal.Application):
    def __init__(self):
        super().__init__(instance_name="astal")
        self.logger = getLogger("ShellApp")
        self.conf = Config.get_default()

    def do_astal_application_request(
        self, msg: str, conn: Gio.SocketConnection
    ) -> None:
        self.logger.info("Received a request: %s", msg)

        args = msg.split(" ")

        if args[0] == "help":
            AstalIO.write_sock(conn, "Available commands:\n")

        if args[0] == "reload":
            self.logger.info("Reloading css...")
            self.reload()
    
    def reload(self):
        self.logger.debug("Triggering wallpaper change...")
        self.conf.wallpaper.trigger()

        self.logger.debug("Compiling scss...")
        compile_scss()

        self.logger.debug("Applying css...")
        self.apply_css(str(CONFIG_DIR / "style/style.css"), True)
    
    def do_activate(self) -> None:
        self.hold()
        self.reload()

        for m in self.get_monitors():
            self.add_window(Bar(m))

app = ShellApp()

if __name__ == "__main__":
    # init_log(debug=True if "-d" in sys.argv or "--debug" in sys.argv else False)
    app.acquire_socket()
    app.run()
    Task.stop_cancellable_tasks()