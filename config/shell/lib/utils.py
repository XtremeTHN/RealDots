from gi.repository import Gtk, GObject, Gio
from inotify.constants import IN_MODIFY
from inotify.adapters import Inotify
from lib.logger import getLogger
from typing import TypeVar
from lib.task import Task

class Box(Gtk.Box):
    def __init__(self, vertical=False, spacing=0, children=[], css_classes=[], **kwargs):
        """
        Helper class for :class:`Gtk.Box`
        
        :param vertical: If True, the box will be vertical. Otherwise horizontal.
        :param spacing: The spacing between each child.
        :param children: An iterable of :class:`Gtk.Widget` to append to the box.
        :param css_classes: A list of CSS classes to apply to the box.
        """
        super().__init__(orientation=Gtk.Orientation.VERTICAL if vertical else Gtk.Orientation.HORIZONTAL, spacing=spacing, css_classes=css_classes, **kwargs)
        self.__children = []
        self.append_all(children)

    @GObject.Property()
    def children(self):
        return self.__children

    @children.setter
    def children(self, value):
        self.__children = value
        self.clear()
        self.append_all(value)
        self.notify("children")

    def clear(self):
        while (w:=self.get_last_child()) is not None:
            self.remove(w)

    def append_all(self, children):
        """
        Appends all elements of `children` to the box.

        :param children: An iterable of :class:`Gtk.Widget` to append to the box
        """
        for c in children:
            self.append(c)
    
    def append(self, child):
        """
        Appends a single :class:`Gtk.Widget` to the box.

        :param child: The :class:`Gtk.Widget` to append to the box
        """
        super().append(child)
        self.__children.append(child)
        self.notify("children")
    
class Watcher(GObject.Object, Task):
    __gsignals__ = {
        "event": (GObject.SignalFlags.RUN_FIRST, None, (str,))
    }

    def __init__(self):
        self.logger = getLogger("Watcher")
        self._name = "Watcher"
        GObject.Object.__init__(self)
        Task.__init__(self, self.__run)

        self.cancellable = Gio.Cancellable.new()
        self.watcher = Inotify()

    def add_watch(self, path, mask=IN_MODIFY):
        self.watcher.add_watch(path, mask=mask)
        self._name = path
    
    def stop(self):
        self.logger.info("[%s] Stopping...", self._name)
        self.cancellable.cancel()

    def __run(self):
        for event in self.watcher.event_gen():
            if self.cancellable.is_cancelled():
                break

            if event is not None:
                self.emit("event", event)

T = TypeVar("T", bound="Object")
class Object(GObject.Object):
    _instance = None
    def __init__(self):
        super().__init__()
    
    @classmethod
    def get_default(cls: type[T]) -> T:
        """
        Returns the default Service object for this process, creating it if necessary.
        """
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance
