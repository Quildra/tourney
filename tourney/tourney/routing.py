import cherrypy
import sys

class App(object):

    # How the templating system works
    # Example 1
    # The snippet below programatically works out the template to use from the class name (WebInterface) and the method name (index)
    #    it will also append ".mako" as the extention
    # So it will look for App/index.mako
    @cherrypy.tools.template
    def index(self):
        pass
    
    # Example 2
    # The snippet below shows how you can override the above and specify a template directly to use 
    @cherrypy.tools.template(name="app/index")
    def home(self):
        pass