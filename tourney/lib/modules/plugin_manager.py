import sys
import os
from lib.configobj.configobj import ConfigObj
from lib.configobj.helpers import check_section, check_setting_str, check_setting_int

# Base class that all plugins must inherit from.
class Plugin(object):
    def assoicate_metadata(self, meta):
        self.metadata = meta
    
class MetaData(object):
    def __init__(self, file):
        self.name = ''
        self.version = ''
        self.author = ''
        self.module_name = ''
        
        config = ConfigObj(file, encoding='utf-8')
        if config is None:
            return
            
        if check_section(config, 'Regestration') is False:
            return
            
        self.name = check_setting_str(config, 'Regestration', 'name', '')
        self.module_name = check_setting_str(config, 'Regestration', 'module_name', '')
        
    def is_valid(self):
        if self.name == '':
            return False
        
        if self.module_name == '':
            return False
            
        return True
    
# Manager class to do the descovery and importing.
class PluginManager():
    plugin_dir = ""
    loaded_plugins = {}
    descovered_plugins = {}
    
    def locate_plugins(self, plugin_dir):
        # Store the plugin directory in case we want to use it later.
        self.plugin_dir = plugin_dir
        
        # Add it to the path so we can import with out needing the full import path
        sys.path.insert(0, self.plugin_dir)
        
        # Look for the .plugin metadata files to load
        plugin_files = [x[:-3] for x in os.listdir(self.plugin_dir) if x.endswith(".py")]
        
        for plugin in plugin_files:
            mod = __import__(plugin)
        
    def register_plugins(self):
        for plugin in Plugin.__subclasses__():
            self.loaded_plugins[plugin.plugin_name] = plugin
        
    def get_plugins(self,group=None):
        return self.loaded_plugins
        
    def get_plugin(self,plugin_name):
        return self.loaded_plugins.get(plugin_name, None)
        