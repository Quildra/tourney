import os.path
import sys
import tempfile
import types

import cherrypy
import mako
from mako import exceptions
from mako.template import Template
from mako.lookup import TemplateLookup

__all__ = ['MakoTool']

class MakoTool(cherrypy.Tool):
    def __init__(self,base_dir=None, base_cache_dir=None,collection_size=50, encoding='utf-8'):
        cherrypy.Tool.__init__(self, 'before_handler', self.render)
        self.base_dir = base_dir
        self.base_cache_dir = base_cache_dir or tempfile.gettempdir()
        self.encoding = encoding
        self.collection_size = collection_size
        self.lookup = TemplateLookup(directories=self.base_dir,
                                     module_directory=self.base_cache_dir,
                                     input_encoding=self.encoding,
                                     output_encoding=self.encoding,
                                     collection_size=self.collection_size)
        
    
    def __call__(self, *args, **kwargs):
        if args and isinstance(args[0], (types.FunctionType, types.MethodType)):
            # @template
            args[0].exposed = True
            return cherrypy.Tool.__call__(self, **kwargs)(args[0])
        else:
            # @template()
            def wrap(f):
                f.exposed = True
                return cherrypy.Tool.__call__(self, *args, **kwargs)(f)
            return wrap

    def render(self, name = None):
        cherrypy.request.config['template'] = name

        handler = cherrypy.serving.request.handler
        def wrap(*args, **kwargs):
          return self._render(handler, *args, **kwargs)
        cherrypy.serving.request.handler = wrap
    
    def _render(self, handler, *args, **kwargs):
        template = cherrypy.request.config['template']
        if not template:
            parts = []
            if hasattr(handler.callable, '__self__'):
                parts.append(handler.callable.__self__.__class__.__name__.lower())
            if hasattr(handler.callable, '__name__'):
                parts.append(handler.callable.__name__.lower())
            template = u'/'.join(parts)

        data     = handler(*args, **kwargs) or {}
        renderer = self.lookup.get_template(u'{0}.mako'.format(template))

        return renderer.render(**data)