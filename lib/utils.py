from gi.repository import Gtk, GObject

class Box(Gtk.Box):
    def __init__(self, vertical=False, spacing=0, children=[], css_classes=[]):
        """
        Helper class for :class:`Gtk.Box`
        
        :param vertical: If True, the box will be vertical. Otherwise horizontal.
        :param spacing: The spacing between each child.
        :param children: An iterable of :class:`Gtk.Widget` to append to the box.
        :param css_classes: A list of CSS classes to apply to the box.
        """
        super().__init__(orientation=Gtk.Orientation.VERTICAL if vertical else Gtk.Orientation.HORIZONTAL, spacing=spacing, css_classes=css_classes)
        self.__children = []
        self.append_all(children)

    @GObject.Property()
    def children(self):
        return self.__children

    @children.setter
    def children(self, value):
        self.__children = value
        while (w:=self.get_last_child()) is not None:
            self.remove(w)
        self.append_all(value)
        self.notify("children")

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