import lib.versions
import lib.blueprints

from gi.repository import Astal, AstalIO, Gio

from widgets.bar.bar import Bar
from lib.task import Task
from lib.style import compile_scss
from lib.config import Config
from lib.constants import CONFIG_DIR

conf = Config.get_default()

class ShellApp(Astal.Application):
    def __init__(self):
        super().__init__(instance_name="astal")
        self.conf = conf.get_default()

    def do_astal_application_request(
        self, msg: str, conn: Gio.SocketConnection
    ) -> None:
        args = msg.split(" ")

        if args[0] == "help":
            AstalIO.write_sock(conn, "Available commands:\n")

        if args[0] == "reload":
            self.reload()
    
    def reload(self):
        self.conf.wallpaper.trigger()
        compile_scss()
        self.apply_css(str(CONFIG_DIR / "style/style.css"), True)
    

    def do_activate(self) -> None:
        self.hold()
        self.reload()

        for m in self.get_monitors():
            self.add_window(Bar(m))

app = ShellApp()

if __name__ == "__main__":
    app.acquire_socket()
    app.run()
    Task.stop_cancellable_tasks()