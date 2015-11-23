# -*- coding: utf-8 -*-
from sqlalchemy import Column, ForeignKey
from sqlalchemy.types import Unicode, Integer, Date
from sqlalchemy.orm import relationship, backref

from lib.models import Base

__all__ = ['User']

class User(Base):
    __tablename__ = 'user'
    id = Column(Integer, nullable=False, primary_key=True)
    username = Column(Unicode)
    hash = Column(Unicode)
    salt = Column(Unicode)
    email = Column(Unicode)
    join_date = Column(Date)
    role_id = Column(Integer, ForeignKey('role.id'))
    
    role = relationship("Role", backref=backref('role', order_by=id))
        
    @staticmethod
    def get_by_username(session, uid):
        return session.query(User).filter(User.username==uid).one()

    @staticmethod
    def all(session):
        return session.query(User)