# -*- coding: utf-8 -*-
from sqlalchemy import Column
from sqlalchemy.types import Unicode, Integer, Date

import datetime

from lib.models import Base

__all__ = ['Event']

class Event(Base):
    __tablename__ = 'event'
    id = Column(Integer, nullable=False, primary_key=True)
    name = Column(Unicode, nullable=False)
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=True)
    
    @staticmethod
    def get_by_id(session, id):
        return session.query(Event).filter(Event.id == id).first()
    
    @staticmethod
    def active_events(session):
        return session.query(Event).filter(Event.start_date <= datetime.date.today(), Event.end_date >= datetime.date.today()).all()
        
    @staticmethod
    def future_events(session):
        return session.query(Event).filter(Event.start_date > datetime.date.today()).all()
        
    @staticmethod
    def past_events(session):
        return session.query(Event).filter(Event.end_date < datetime.date.today()).all()