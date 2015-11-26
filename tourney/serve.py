import os

import cherrypy
from lib.configobj.configobj import ConfigObj

import tourney
from tourney import webstart

def main():
    tourney.FULL_PATH = os.path.abspath(__file__)
    tourney.PROG_DIR = os.path.dirname(tourney.FULL_PATH)
    tourney.CONFIG_FILE = os.path.join(tourney.PROG_DIR, 'config.ini')
    tourney.CFG = ConfigObj(tourney.CONFIG_FILE, encoding='utf-8')
    tourney.initialise()

    webstart.initialise({
            'http_port':        tourney.HTTP_PORT,
            'http_host':        tourney.HTTP_HOST,
            'http_root':        tourney.HTTP_ROOT,
            })


if __name__ == '__main__':
    main()
