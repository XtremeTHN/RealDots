from gi.repository import GObject
from lib.task import Task, Event
from inotify.adapters import Inotify
from inotify.constants import IN_MODIFY
from typing import TypeVar
from lib.constants import JSON_CONFIG_PATH
import json

T = TypeVar("T", bound="_conf")
SettingsObj = TypeVar("SettingsObj", bound="Settings")

class opt(GObject.GObject):
    __gsignals__ = {
        "changed": (GObject.SignalFlags.RUN_FIRST, None, ()),
    }
    def __init__(self, keys: list[str], settings_obj: SettingsObj):
        super().__init__()
        self.settings_obj = settings_obj
        self.keys = keys
        self._value = self.__get()

        self.settings_obj.connect("changed", self.__settings_changed)
        self.__settings_changed(None)
    
    def on_change(self, function, once=False):
        if once is True:
            function(None)
        self.connect("changed", function)
    
    def trigger(self):
        self.emit("changed")
    
    def __get(self):
        self._dict = self.settings_obj.content
        for key in self.keys:
            if key not in self._dict:
                return
            self._dict = self._dict[key]

        return self._dict

    def __set(self, value):
        try:
            exec('self.settings_obj.content' + ".".join(f"[{key}]" for key in self.keys) + " = value")
        except Exception as e:
            print("failed to set value:", e)

    def __settings_changed(self, _): 
        if (v:=self.__get()) is not None:
            if v != self._value:
                self._value = v
                self.emit("changed")
        else:
            self._set = False
    
    def is_set(self):
        return self._value is not None

    @GObject.Property(nick="value")
    def value(self):
        return self._value
    
    @value.setter
    def value(self, value):
        self.__set(value)
        self.settings_obj.save()

        self.emit("changed")

class Settings(GObject.Object, Task):
    __gsignals__ = {
        "changed": (GObject.SignalFlags.RUN_FIRST, None, ()),
    }
    def __init__(self, filename):
        GObject.Object.__init__(self)
        Task.__init__(self, self.__run)

        self.filename = filename
        self.observer = Inotify()
        self.observer.add_watch(filename, mask=IN_MODIFY)

        with open(self.filename, "r") as f:
            self.content = json.load(f)
        self.should_stop = Event()

    def __run(self):
        if self.observer is not None:
            try:
                for event in self.observer.event_gen():
                    if self.should_stop.is_set():
                        break
                    if event is not None:
                        try:
                            with open(self.filename, "r") as f:
                                self.content = json.load(f)
                        except Exception as e:
                            print("failed to parse json:", e)
                        self.emit("changed")
            except KeyboardInterrupt:
                self.stop()
    
    def stop(self):
        self.observer.remove_watch(self.filename)
        self.should_stop.set()
    
    def get_opt(self, key):
        return opt(key.split("."), self)
    
    def save(self):
        with open(self.filename, "w") as f:
            f.write(json.dumps(self.content))
            self.emit("changed")

class Config:
    _instance = None
    def __init__(self):
        self.conf = Settings(str(JSON_CONFIG_PATH))
        self.conf.start()

        self.profile_picture = self.conf.get_opt("profile.picture")
        self.hostname = self.conf.get_opt("profile.hostname")
        self.wallpaper = self.conf.get_opt("background.wallpaper")

        self.player = self.conf.get_opt("bar.music-player")

    @classmethod
    def get_default(cls: type[T]) -> T:
        """
        Returns the default Service object for this process, creating it if necessary.
        """
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance
