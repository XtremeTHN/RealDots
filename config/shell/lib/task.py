from threading import Event, Thread
import time

class TaskWrapper:
    def __init__(self, object, method: str):
        self.object = object
        self.method = method
    
    def stop(self):
        getattr(self.object, self.method)()

class Task(Thread):
    unfinished_cancelable_tasks = []
    def __init__(self, function, *args, **kwargs):
        super().__init__()

        self.prepare = lambda *_: None
        self.finalize = lambda *_: None

        self.func = function
        self.args = args
        self.kwargs = kwargs
    
    def run(self):
        Task.unfinished_cancelable_tasks.append(self)
        self.prepare()
        self.func(*self.args, **self.kwargs)
        self.finalize()
        Task.unfinished_cancelable_tasks.remove(self)
    
    def stop(self):
        """Implement this function if you want to add a stop function to the task"""
        ...

    @staticmethod
    def add_cancellable_task(task):
        Task.unfinished_cancelable_tasks.append(task)

    @staticmethod
    def stop_cancellable_tasks():
        for task in Task.unfinished_cancelable_tasks:
            task.stop()

class LoopTask(Task):
    def __init__(self, function, delay=0, *args, **kwargs):
        """
        Initializes a LoopTask with a given function, delay and arguments.

        :param function: The function to run.
        :param delay: The delay in seconds between each function call.
        :param \\*args: Arguments to pass to the function.
        :param \\*\\*kwargs: Keyword arguments to pass to the function.
        """
        
        super().__init__(function, *args, **kwargs)
        self.delay = delay
        self.should_stop = Event()
    
    def stop(self):
        self.should_stop.set()
        Task.unfinished_cancelable_tasks.remove(self)
    
    def run(self):
        Task.unfinished_cancelable_tasks.append(self)
        while self.should_stop.is_set() == False:
            self.func(*self.args, **self.kwargs)
            time.sleep(self.delay)
        try:
            Task.unfinished_cancelable_tasks.remove(self)
        except:
            pass

    def start(self):
        self.should_stop.clear()
        super().start()