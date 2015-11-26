import os
import sys

import cherrypy

import tourney

def initialise(options={}):
    cherrypy.config.update({
        'engine.autoreload.on': True,
        'server.socket_port':   options['http_port'],
        'server.socket_host':   options['http_host'],
        })

    conf = {
        '/': {
            'tools.staticdir.root': os.path.join(tourney.PROG_DIR, 'public')
        },
        '/semantic':{
            'tools.staticdir.on': True,
            'tools.staticdir.dir': "semantic"
        },
        '/css':{
            'tools.staticdir.on': True,
            'tools.staticdir.dir': "css"
        },
        '/js':{
            'tools.staticdir.on': True,
            'tools.staticdir.dir': "js"
        },
    }

    engine = cherrypy.engine

    # We amend the system path so that Python can find the application's modules.
    sys.path.insert(0, tourney.PROG_DIR)

    from lib.tools.template import MakoTool
    cherrypy.tools.template = MakoTool(os.path.join(tourney.PROG_DIR, 'templates'), os.path.join(tourney.PROG_DIR, 'cache'))

    # Database access tool
    from lib.tools.db import SATool
    cherrypy.tools.db = SATool()

    cherrypy.engine.timeout_monitor.unsubscribe()

    from tourney.routing import App
    webapp = App()
    cherrypy.tree.mount(webapp, options['http_root'], config = conf)

    # Database connection management plugin
    from lib.plugins.db import SAEnginePlugin
    engine.db = SAEnginePlugin(engine)
    engine.db.subscribe()

    try:
        cherrypy.process.servers.check_port(options['http_host'], options['http_port'])
        if hasattr(engine, "signal_handler"):
            engine.signal_handler.subscribe()

        if hasattr(engine, "console_control_handler"):
            engine.console_control_handler.subscribe()

        #cherrypy.server.start()
        engine.signals.subscribe()
        engine.start()
        engine.db.seed_data()
        engine.block()
    except IOError:
        print('Failed to start on port: %i. Is something else running?' % (options['http_port']))
        sys.exit(0)

    cherrypy.server.wait()
