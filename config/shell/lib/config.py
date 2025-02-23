from gi.repository import GObject
from lib.task import Task, Event
from inotify.adapters import Inotify
from inotify.constants import IN_MODIFY
from typing import TypeVar
from lib.constants import JSON_CONFIG_PATH
from pathlib import Path
from lib.logger import getLogger
from lib.utils import Object
import json

SettingsObj = TypeVar("SettingsObj", bound="Json")

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

class Json(GObject.Object, Task):
    __gsignals__ = {
        "changed": (GObject.SignalFlags.RUN_FIRST, None, ()),
    }
    def __init__(self, file_obj: Path):
        GObject.Object.__init__(self)
        Task.__init__(self, self.__run)

        if file_obj.is_file() is False:
            file_obj.touch()
        
        self.file_obj = file_obj
        self.logger = getLogger("Json")
        self.observer = Inotify()
        self.observer.add_watch(str(file_obj), mask=IN_MODIFY)

        self.content = {}
        self.__read_content()

        self.should_stop = Event()
    
    def __read_content(self):
        try:
            self.content = json.loads(self.file_obj.read_text())
        except:
            self.logger.exception("Failed to parse json")
            self.logger.info("Config unchanged")

    def __run(self):
        if self.observer is not None:
            try:
                for event in self.observer.event_gen():
                    if self.should_stop.is_set():
                        break
                    if event is not None:
                        self.logger.debug("Recieved event: %s", event)
                        self.__read_content()
                        self.emit("changed")
            except KeyboardInterrupt:
                self.stop()
    
    def stop(self):
        self.logger.info("Stopping...")
        self.observer.remove_watch(str(self.file_obj))
        self.should_stop.set()
    
    def get_opt(self, key):
        return opt(key.split("."), self)
    
    def save(self):
        self.logger.info("Saving config...")
        try:
            self.file_obj.write_text(json.dumps(self.content))
        except:
            self.logger.exception("Failed to save config")

class Config(Object):
    def __init__(self):
        self.conf = Json(JSON_CONFIG_PATH)
        self.conf.start()

        self.profile_picture = self.conf.get_opt("profile.picture")
        self.wallpaper = self.conf.get_opt("background.wallpaper")

        self.player = self.conf.get_opt("bar.music-player")

