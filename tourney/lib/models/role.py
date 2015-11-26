# -*- coding: utf-8 -*-
from sqlalchemy import Column
from sqlalchemy.types import Unicode, Integer
from sqlalchemy.orm import relationship, backref

from lib.models import Base

__all__ = ['Role']

class Role(Base):
    __tablename__ = 'role'
    id = Column(Integer, nullable=False, primary_key=True)
    name = Column(Unicode)
    
    users = relationship("User", order_by="User.id", backref="user")
        
    @staticmethod
    def get_by_id(session, id):
        return session.query(Role).filter(Role.id == id).one()

    @staticmethod
    def all(session):
        return session.query(Role)