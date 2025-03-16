from pathlib import Path
from typing import TypeVar
from lib.utils import Watcher
from lib.logger import getLogger
from gi.repository import GObject
import json

SettingsObj = TypeVar("SettingsObj", bound="Json")

class opt(GObject.GObject):
    __gsignals__ = {
        "changed": (GObject.SignalFlags.RUN_FIRST, None, ()),
    }
    def __init__(self, keys: list[str], settings_obj: SettingsObj, default_value=None):
        super().__init__()
        self.logger = settings_obj.logger
        self.settings_obj = settings_obj
        self.keys = keys
        self._value = default_value if (n:=self.__get()) is None else n

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
        python_line = 'self.settings_obj.content' + "".join(f"[{key}]" for key in self.keys) + " = value"
        try:
            exec(python_line)
        except:
            self.logger.exception("Failed to set value")
            self.logger.debug("formatted python line: %s", python_line)

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

class Json(Watcher):
    __gsignals__ = {
        "changed": (GObject.SignalFlags.RUN_FIRST, None, ())
    }
    def __init__(self, file_obj: Path):
        """
        Initializes a Json object.

        :param file_obj: The file to watch for changes.
        """
        super().__init__()
        self.logger = getLogger("Watcher (Json)")

        if file_obj.is_file() is False:
            file_obj.write_text("{}")

        self.add_watch(str(file_obj))
        self.file_obj = file_obj

        self.content = {}
        self.__read_content()
        
        self.connect("event", self.__on_event)
        self.start()
    
    def __read_content(self):
        try:
            self.content = json.loads(self.file_obj.read_text())
        except:
            self.logger.exception("Failed to parse json")
            self.logger.info("Config unchanged")
    
    def __on_event(self, _, event):
        self.logger.debug("Recieved event: %s", event)
        self.__read_content()
        self.emit("changed")

    def stop(self):
        self.logger.info("Stopping...")
        self.watcher.remove_watch(str(self.file_obj))
        self.cancellable.cancel()
    
    def get_opt(self, key, default=None):
        return opt(key.split("."), self, default)
    
    def save(self):
        self.logger.info("Saving config...")
        try:
            self.file_obj.write_text(json.dumps(self.content))
        except:
            self.logger.exception("Failed to save config")