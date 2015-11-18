# -*- coding: utf-8 -*-
from sqlalchemy import Column
from sqlalchemy.types import Unicode, Integer, Date

from lib.models import Base

__all__ = ['Event']

class Event(Base):
	__tablename__ = 'event'
	id = Column(Integer, nullable=False, primary_key=True)
	name = Column(Unicode, nullable=False)
	start_date = Column(Date, nullable=False)
	end_date = Column(Date, nullable=True)