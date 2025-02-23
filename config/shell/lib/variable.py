import time
from gi.repository import GObject, GLib

from lib.task import LoopTask

class Variable(GObject.GObject):
    __gsignals__ = {
        "changed": (GObject.SIGNAL_RUN_FIRST, None, tuple())
    }
    def __init__(self, value):
        GObject.GObject.__init__(self)

        self.func = None
        self.user_data = []
        self.user_data_kwargs = {}

        self.poll_miliseconds = 0
        self.value = value

    def __poll(self, delay, function, *user_data, **user_data_kwargs):
        self.value = function(*user_data, **user_data_kwargs)
        self.emit("changed")
        time.sleep(delay / 1000)
    
    def connect(self, detailed_signal, handler, *args):
        """
        Connects the handler to the signal. Use GLib.idle if you are calling widget functions in the handler
        """
        return super().connect(detailed_signal, handler, *args)
    
    def poll(self, milliseconds, function, *user_data, **user_data_kwargs):
        poll_miliseconds = milliseconds
        func = function
        user_data = user_data
        user_data_kwargs = user_data_kwargs

        LoopTask(self.__poll, poll_miliseconds, func, *user_data, **user_data_kwargs).start()

        return self