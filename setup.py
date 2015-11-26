from setuptools import setup

setup(name='tourney',
    version='0.1',
    description='Extendable tournament web server',
    url='',
    author='Quildra',
    license='MIT',
    packages=['tourney'],
    install_requires=[
        'cherrypy',
        'mako',
        'SQLAlchemy',
        'ConfigObj'
    ],
    zip_safe=False)
