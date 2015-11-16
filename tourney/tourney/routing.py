import cherrypy
import sys

class WebInterface(object):
  @cherrypy.expose
  @cherrypy.tools.render(template="index.mako")
  def index(self):
      pass
