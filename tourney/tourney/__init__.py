import threading
import os
from lib.configobj.configobj import ConfigObj
from lib.configobj.helpers import check_section, check_setting_str, check_setting_int
from lib.modules.plugin_manager import PluginManager

#General
CONFIG_VERSION = None
HTTP_PORT = None
HTTP_HOST = None
HTTP_ROOT = None
CACHE_DIR = None
LOG_DIR = None
VERBOSE = None

#Globals
FULL_PATH = None
PROG_DIR = None
CONFIG_FILE = None
CFG = None
PLUGIN_MANAGER = PluginManager()
INIT_LOCK = threading.Lock()

__INITIALISED__ = False

def initialise():
    with INIT_LOCK:
        global CONFIG_VERSION,HTTP_PORT,HTTP_HOST,HTTP_ROOT,CACHE_DIR,LOG_DIR,FULL_PATH,PROG_DIR,CONFIG_FILE,CFG,INIT_LOCK,VERBOSE,__INITIALISED__

        if __INITIALISED__:
            return False

        check_section(CFG,'General')

        try:
            HTTP_PORT = check_setting_int(CFG, 'General', 'http_port', 8091)
        except:
            HTTP_PORT = 8091

        if HTTP_PORT < 21 or HTTP_PORT > 65535:
            HTTP_PORT = 8091

        HTTP_HOST = check_setting_str(CFG, 'General', 'http_host', '0.0.0.0')
        HTTP_ROOT = check_setting_str(CFG, 'General', 'http_root', '/')
        CONFIG_VERSION = check_setting_str(CFG, 'General', 'config_version', '1')
        CACHE_DIR = check_setting_str(CFG, 'General', 'cache_dir', '')
        VERBOSE = check_setting_str(CFG, 'General', 'log_level', 1)
        LOG_DIR = check_setting_str(CFG, 'General', 'log_dir', '')

        if not LOG_DIR:
            LOG_DIR = os.path.join(PROG_DIR, 'logs')

        if not os.path.exists(LOG_DIR):
            os.makedirs(LOG_DIR)
            
        PLUGIN_MANAGER.locate_plugins(os.path.join(PROG_DIR, 'extentions'))
        PLUGIN_MANAGER.register_plugins()

        config_write()

        __INITIALISED__ = True
        return True

def config_write():
    new_config = ConfigObj()
    new_config.filename = CONFIG_FILE

    new_config.encoding = 'UTF8'
    new_config['General'] = {}
    new_config['General']['config_version'] = CONFIG_VERSION
    new_config['General']['http_port'] = HTTP_PORT
    new_config['General']['http_host'] = HTTP_HOST
    new_config['General']['http_root'] = HTTP_ROOT
    new_config['General']['log_level'] = VERBOSE
    new_config['General']['log_dir'] = LOG_DIR
    new_config['General']['cache_dir'] = CACHE_DIR

    new_config.write()
