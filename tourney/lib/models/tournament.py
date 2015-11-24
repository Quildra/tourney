# -*- coding: utf-8 -*-
from sqlalchemy import Column, ForeignKey
from sqlalchemy.types import Unicode, Integer, Time, Boolean
from sqlalchemy.orm import relationship, backref

import datetime

from lib.models import Base

__all__ = ['Tournament']

class Tournament(Base):
    __tablename__ = 'tournament'
    id = Column(Integer, nullable=False, primary_key=True)
    event_id = Column(Integer, ForeignKey('event.id'))
    game_system_id = Column(Unicode)
    pairing_system_id = Column(Unicode)
    reg_start_time = Column(Time, nullable=False)
    reg_end_time = Column(Time, nullable=True)
    round_one_start_time = Column(Time, nullable=True)
    player_limit = Column(Integer)
    team_event = Column(Boolean)
    players_per_team = Column(Integer)
    description = Column(Unicode)
    
    event = relationship("Event", backref=backref('event', order_by=id))