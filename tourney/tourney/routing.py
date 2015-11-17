import cherrypy
import sys
import hashlib
import binascii

from lib.modules.simple_auth import AuthController, require, member_of, name_is, generate_salt

from lib.models.user import User

class Admin(object):

    _cp_config = {
        'auth.require': [member_of('admin')],
        'tools.db.on': True
    }

    @cherrypy.tools.template
    def index(self):
        pass

class Debug(object):

    @cherrypy.expose
    def addJoe(self):
        db = cherrypy.request.db

        salt = generate_salt()
        dk = hashlib.pbkdf2_hmac('sha256', b'secret', salt, 100000)
        binascii.hexlify(dk)

        joe = User(username='joe', hash=dk, salt=salt)
        db.add(joe)
        raise cherrypy.HTTPRedirect("/")

class App(object):

    _cp_config = {
        'tools.sessions.on': True,
        'tools.auth.on': True,
        'tools.db.on': True
    }

    # Any objects created like this will get mounted to the url tree if
    # they have mthods that are exposed via @cherrpy.expose or the
    # @cherrypy.tools.template markup
    auth = AuthController()
    admin = Admin()
    debug = Debug()

    # How the templating system works
    # Example 1
    # The snippet below programatically works out the template to use from the class name (WebInterface) and the method name (index)
    #    it will also append ".mako" as the extention
    # So it will look for App/index.mako
    @cherrypy.tools.template
    def index(self):
        db = cherrypy.request.db
        pass

    # Example 2
    # The snippet below shows how you can override the above and specify a template directly to use
    @cherrypy.tools.template(name="app/index")
    def home(self):
        pass
