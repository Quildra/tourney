from lib.modules.plugin_manager import Plugin
from test_module.work import different_message

class Test(Plugin):
    plugin_name = 'Tiddlywinks by Dan'
    version = '0.1'
    game_system = 'Tiddlywinks'
    
    def message():
        print("Test - Hello")
        different_message()