import cherrypy
import sys
import hashlib
import binascii
import datetime
from datetime import date

from lib.modules.simple_auth import AuthController, require, member_of, name_is, generate_salt

from lib.models.user import User
from lib.models.event import Event
from lib.models.role import Role

import tourney

class AdminEvents(object):
    @cherrypy.tools.template(name="admin/events/index")
    def index(self):
        db = cherrypy.request.db
        active_events = Event.active_events(db)
        future_events = Event.future_events(db)
        past_events = Event.past_events(db)
            
        return {'active_events': active_events, 'future_events': future_events, 'past_events': past_events,}
        
    @cherrypy.expose
    def create(self, **kwargs):
        
        new_event = Event()
        new_event.name = kwargs['event_name']
        new_event.start_date = datetime.datetime.strptime(kwargs['start_date'],"%d/%m/%Y").date()
        
        if kwargs['uid'] != "":
            new_event.id = kwargs['uid']
            
        if kwargs['end_date'] != "":
            new_event.end_date = datetime.datetime.strptime(kwargs['end_date'],"%d/%m/%Y").date()
        else:
            new_event.end_date = new_event.start_date
        
        db = cherrypy.request.db
        db.add(new_event)
        
        raise cherrypy.HTTPRedirect("/admin/events/")
    
    @cherrypy.tools.template(name="admin/events/manage")
    def manage(self, event_id = None,**kwargs):
        if event_id is None:
            raise cherrypy.HTTPRedirect("/admin/events/")
            
        db = cherrypy.request.db
        event = Event.get_by_id(db,event_id)
        
        plugins = tourney.PLUGIN_MANAGER.get_plugins("Game system")
        
        return {'selected_event': event, 'game_systems': plugins}
        
    @cherrypy.expose
    def delete(self, **kwargs):
        db = cherrypy.request.db
        event = Event.get_by_id(db, kwargs['uid'])
        if event is not None:
            db.delete(event)
            
        raise cherrypy.HTTPRedirect("/admin/events/")
        

class Admin(object):

    _cp_config = {
        'auth.require': [member_of('Admin')],
        'tools.db.on': True
    }

    events = AdminEvents();

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
        
        today = date.today()
        joe = User(username='joe', hash=dk, salt=salt, email='joe@joe.com', join_date=today, role_id=1)
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
