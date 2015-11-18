# -*- coding: utf-8 -*-
from sqlalchemy import Column
from sqlalchemy.types import Unicode, Integer

from lib.models import Base

__all__ = ['User']

class User(Base):
    __tablename__ = 'user'
    id = Column(Integer, nullable=False, primary_key=True)
    username = Column(Unicode)
    hash = Column(Unicode)
    salt = Column(Unicode)
        
    @staticmethod
    def get_by_username(session, uid):
        return session.query(User).filter(User.username==uid).first()

    @staticmethod
    def all(session):
        return session.query(User)