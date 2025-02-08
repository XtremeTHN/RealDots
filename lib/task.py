from threading import Event, Thread

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

    def stop_cancellable_tasks():
        for task in Task.unfinished_cancelable_tasks:
            task.stop()

class LoopTask(Task):
    def __init__(self, function, *args, **kwargs):
        super().__init__(function, *args, **kwargs)

        self.should_stop = Event()
    
    def stop(self):
        self.should_stop.set()
        Task.unfinished_cancelable_tasks.remove(self)
    
    def run(self):
        Task.unfinished_cancelable_tasks.append(self)
        while self.should_stop.is_set() == False:
            self.func(*self.args, **self.kwargs)
        try:
            Task.unfinished_cancelable_tasks.remove(self)
        except:
            pass

    def start(self):
        self.should_stop.clear()
        super().start()