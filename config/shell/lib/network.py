from gi.repository import AstalNetwork, GObject, NM, GLib
from lib.logger import getLogger
from lib.utils import Object

class NotWifi(Exception):
    pass

class NWrapper(Object):
    __gsignals__ = {
        "changed": (GObject.SignalFlags.RUN_FIRST, None, tuple())
    }
    icon_name = GObject.Property(type=str, default="network-wired-symbolic", nick="icon-name")
    ssid = GObject.Property(type=str, default="Disconnected", nick="ssid")
    def __init__(self):
        GObject.GObject.__init__(self)
        self.logger = getLogger("NetworkIndicator")

        self.net = AstalNetwork.get_default()
        self.wifi = self.net.get_wifi()
        self.wired = self.net.get_wired()
        self.client = self.net.get_client()
        self.__icon_binding = None
        self.__ssid_binding = None
        self.__bind_device_props()

        self.net.connect('notify::wifi', self.on_wifi_changed)
        self.net.connect('notify::wired', self.on_wired_changed)
    
    def __bind_icon(self, obj: GObject.Object):
        if self.__icon_binding is not None:
            self.__icon_binding.unbind()
        self.__icon_binding = obj.bind_property("icon-name", self, "icon-name", GObject.BindingFlags.SYNC_CREATE)
    
    def __bind_ssid(self):
        if self.__ssid_binding is not None:
            self.__ssid_binding.unbind()
        self.__ssid_binding = self.wifi.bind_property("ssid", self, "ssid", GObject.BindingFlags.SYNC_CREATE)
    
    def __unbind_all(self):
        if self.__icon_binding is not None:
            self.__icon_binding.unbind()
        if self.__ssid_binding is not None:
            self.__ssid_binding.unbind()
    
    def __bind_device_props(self):
        if self.is_wired():
            self.logger.debug("Changing state to wired...")
            self.__bind_icon(self.wired)
            self.ssid = self.get_connected_name()
        elif self.is_wifi():
            self.logger.debug("Changing state to wifi...")
            self.__bind_icon(self.wifi)
            self.__bind_ssid()
        else:
            self.__unbind_all()
            self.icon_name = "network-wireless-disabled-symbolic"
            self.ssid = "Disconnected (No device)"

    def is_wired(self):
        if self.wired.get_state() != AstalNetwork.DeviceState.UNAVAILABLE:
            return True
        return False
    
    def is_wifi(self):
        if self.wifi is not None:
            return True
        return False
    
    def get_connected_name(self):
        if self.is_wired():
            return "Connected (Wired)"
        elif self.is_wifi():
            return self.wifi.get_ssid()
        else:
            return "No device"
    
    def on_wifi_changed(self, _, __):
        self.wifi = self.net.get_wifi()
        self.__bind_device_props(self.wifi)
        self.emit("changed")

    def on_wired_changed(self, _, __):
        self.wired = self.net.get_wired()
        self.__bind_device_props(self.wired)
        self.emit("changed")
    
    def __get_connection(self, ssid, password):
        # from https://fedoramagazine.org/using-python-and-networkmanager-to-control-the-network/
        con = NM.SimpleConnection.new()
        ssid = GLib.Bytes.new(ssid.encode())

        con_conf = NM.SettingConnection.new()
        con_conf.set_property(NM.SETTING_CONNECTION_ID, "astal-connection")
        con_conf.set_property(NM.SETTING_CONNECTION_TYPE, "802-11-wireless")

        wifi_conf = NM.SettingWireless.new()
        wifi_conf.set_property(NM.SETTING_WIRELESS_SSID, ssid)
        wifi_conf.set_property(NM.SETTING_WIRELESS_MODE, "infraestructure")

        wsec_conf = NM.SettingWirelessSecurity.new()
        wsec_conf.set_property(NM.SETTING_WIRELESS_SECURITY_KEY_MGMT, "wpa-psk")
        wsec_conf.set_property(NM.SETTING_WIRELESS_SECURITY_PSK, password)

        ip4_conf = NM.SettingIP4Config.new()
        ip4_conf.set_property(NM.SETTING_IP_CONFIG_METHOD, "auto")

        ip6_conf = NM.SettingIP6Config.new()
        ip6_conf.set_property(NM.SETTING_IP_CONFIG_METHOD, "auto")

        con.add_setting(con_conf)
        con.add_setting(wifi_conf)
        con.add_setting(wsec_conf)
        con.add_setting(ip4_conf)
        con.add_setting(ip6_conf)
        return con

    def __on_connection_finish(self, _, result, on_success, on_error):
        try:
            ac = self.client.add_and_activate_connection_finish(result)
            on_success(ac)
        except Exception as e:
            on_error(e)

    def connect_to_ssid(self, ssid, password, on_success, on_error):
        if self.is_wifi() is False:
            raise NotWifi("Not using wifi")
        
        wifi = self.wifi.get_device()
        con = self.__get_connection(ssid, password)

        self.client.add_and_activate_connection_async(con, wifi, None, None, self.__on_connection_finish, on_success, on_error)