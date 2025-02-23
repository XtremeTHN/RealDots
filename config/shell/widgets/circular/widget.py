from gi.repository import Gtk, GObject
import math

class Color:
    def __init__(self, color):
        self.red = 0
        self.green = 0
        self.blue = 0
        self.alpha = 0
        self.parse_color(color)

    def parse_color(self, color):
        if color.startswith('#'):
            color = color[1:]
            self.red = int(color[:2], 16)
            self.green = int(color[2:4], 16)
            self.blue = int(color[4:6], 16)
            self.alpha = 1
        
        if color.startswith('rgba') or color.startswith('rgb'):
            color = color[4:-1]
            color = color.split(',')
            self.red = int(color[0])
            self.green = int(color[1])
            self.blue = int(color[2])
            try:
                self.alpha = int(color[3])
            except:
                self.alpha = 1

class CircularProgress(Gtk.Widget):
    def __init__(self, thickness: int, colors: list[str]):
        super().__init__()
        self.__value = 0
        self.__start_at = 0
        self.__end_at = 0
        self.__inverted = False
        self.__rounded = False

        self.thickness = thickness
        self.foreground, self.background = [Color(x) for x in colors]

        # self.set_draw_func(self.draw)

        self.connect("notify::value", self.queue_draw)
        self.connect("notify::start_at", self.queue_draw)
        self.connect("notify::end_at", self.queue_draw)
        self.connect("notify::inverted", self.queue_draw)
        self.connect("notify::rounded", self.queue_draw)
    
    def queue_draw(self, *_):
        return super().queue_draw()
    
    @GObject.Property(type=float, default=0)
    def value(self):
        return self.__value

    @value.setter
    def value(self, value):
        if value > 1 or value < 0:
            raise ValueError("value must be between 0 and 1")
        self.__value = value
    
    @GObject.Property(type=float, default=0)
    def start_at(self):
        return self.__start_at

    @start_at.setter
    def start_at(self, value):
        self.__start_at = value

    @GObject.Property(type=float, default=0)
    def end_at(self):
        return self.__end_at

    @end_at.setter
    def end_at(self, value):
        self.__end_at = value

    @GObject.Property(type=bool, default=False)
    def inverted(self):
        return self.__inverted

    @inverted.setter
    def inverted(self, value):
        self.__inverted = value

    @GObject.Property(type=bool, default=False)
    def rounded(self):
        return self.__rounded
    
    @rounded.setter
    def rounded(self, value):
        self.__rounded = value
    
    def get_request_mode(self):
        return Gtk.SizeRequestMode.HEIGHT_FOR_WIDTH

    def to_radian(self, percentage):
        return (math.floor(percentage * 100) / 100) * 2 * math.pi

    def is_full_circle(self, start, end, epsilon=1e-10):
        # Ensure that start and end are between 0 and 1
        start = (start % 1 + 1) % 1
        end = (end % 1 + 1) % 1

        # Check if the difference between start and end is close to 1
        return math.fabs(start - end) <= epsilon

    def scale_arc_value(self, start, end, value):
        # Ensure that start and end are between 0 and 1
        start = (start % 1 + 1) % 1
        end = (end % 1 + 1) % 1

        # Calculate the arc length
        arc_length = end - start
        if arc_length < 0:
            arc_length += 1

        # Calculate the position on the arc based on the percentage value
        scaled_value = value + arc_length

        # Ensure that scaled_value is between 0 and 1
        return (scaled_value % 1 + 1) % 1

    def draw(self, _d, ctx, _weight, _height):
        def draw_rounded_back(center_x, center_y, start_progress, end_progress, bg_stroke, radius):
            if self.rounded:
                start_x = center_x + math.cos(start_progress) * radius
                start_y = center_y + math.sin(start_progress) * radius

                end_x = center_x + math.cos(end_progress) * radius
                end_y = center_y + math.sin(end_progress) * radius

                ctx.set_line_width(0)
                ctx.arc(start_x, start_y, bg_stroke / 2, 0, 0 - 0.01)
                ctx.fill()
                ctx.arc(end_x, end_y, bg_stroke / 2, 0, 0 - 0.01)
                ctx.fill()

        allocation = self.get_allocation()

        styles = self.get_style_context()
        width = allocation.width
        height = allocation.height

        margin = styles.get_margin()

        bg_stroke = self.thickness + min([margin.bottom, margin.top, margin.left, margin.right])
        fg_stroke = self.thickness

        radius = min([width, height]) / 2 - max([bg_stroke, fg_stroke]) / 2
        center_x = width / 2
        center_y = height / 2

        start_background = self.to_radian(self.start_at)
        end_background = self.to_radian(self.end_at)
        ranged_value = self.value + self.start_at

        if self.is_full_circle(self.start_at, self.end_at):
            end_background = start_background + 2 * math.pi
            ranged_value = self.to_radian(self.value)
        else:
            ranged_value = self.to_radian(self.scale_arc_value(self.start_at, self.end_at, self.value))

        start_progress = 0
        end_progress = 0

        if self.inverted:
            start_progress = end_background - ranged_value
            end_progress = end_background
        else:
            start_progress = start_background
            end_progress = start_background + ranged_value
        
        ctx.set_source_rgba(self.background.red, self.background.green, self.background.blue, self.background.alpha)

        ctx.arc(center_x, center_y, radius, start_background, end_background)
        ctx.set_line_width(bg_stroke)
        ctx.stroke()

        draw_rounded_back(center_x, center_y, start_progress, end_progress, bg_stroke, radius)

        ctx.set_source_rgba(self.foreground.red, self.foreground.green, self.foreground.blue, self.foreground.alpha)
        ctx.arc(center_x, center_y, radius, start_progress, end_progress)
        ctx.set_line_width(fg_stroke)
        ctx.stroke()

        if self.rounded:
            draw_rounded_back(center_x, center_y, start_progress, end_progress, fg_stroke, radius)
        
        print("ASd")