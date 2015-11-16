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
    cherrypy.tools.render = MakoTool()

    cherrypy.engine.timeout_monitor.unsubscribe()

    from tourney.routing import WebInterface
    webapp = WebInterface()
    cherrypy.tree.mount(webapp, options['http_root'], config = conf)

    # Template engine plugin
    from lib.plugins.template import MakoTemplatePlugin
    engine.mako = MakoTemplatePlugin(engine, os.path.join(tourney.PROG_DIR, 'templates'),
                                     os.path.join(tourney.PROG_DIR, 'cache'))
    engine.mako.subscribe()

    try:
        cherrypy.process.servers.check_port(options['http_host'], options['http_port'])
        if hasattr(engine, "signal_handler"):
            engine.signal_handler.subscribe()

        if hasattr(engine, "console_control_handler"):
            engine.console_control_handler.subscribe()

        cherrypy.server.start()
    except IOError:
        print('Failed to start on port: %i. Is something else running?' % (options['http_port']))
        sys.exit(0)

    cherrypy.server.wait()
