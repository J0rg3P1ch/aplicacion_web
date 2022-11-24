import mysql.connector

from config.config import db_config



class EngineService:
    def __init__(self) -> None:
        self.cursor = None
        self.message = None
        self.db = None
        
    
    
    
    def get_data_engine(self):
        '''
        Regresa la informacion obtenida de la base de datos
        '''
        return self.db, self.cursor, self.message 
    
    
    
    
    def set_data_config(self):
        '''
        Realiza la conexion con la base de datos
        '''
        try:
            self.db = mysql.connector.connect(**db_config)
            self.cursor = self.db.cursor()
        except Exception as ex:
            self.message = str(ex)
            