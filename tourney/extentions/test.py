from lib.modules.plugin_manager import Plugin
from test_module.work import different_message

class Test(Plugin):
    plugin_name = 'test'
    version = '0.1'
    game_system = 'tiddilywinks'
    
    def message():
        print("Test - Hello")
        different_message()