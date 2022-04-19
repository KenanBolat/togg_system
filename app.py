from flask import Flask, request, jsonify 
from flask_cors import CORS, cross_origin
from flask_marshmallow import Marshmallow
from flask_marshmallow.fields import fields
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine
from sqlalchemy import func
from sqlalchemy import over
from sqlalchemy.orm import relationship, backref
from sqlalchemy.orm import scoped_session, sessionmaker, Query
from sqlalchemy.ext.declarative import declarative_base
from geoalchemy2 import Geometry, Geography

import os 
import datetime 

# Init app 
app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'
basedir = os.path.abspath(os.path.dirname(__file__))

# Database 
# app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
engine =  create_engine('postgresql+psycopg2://postgres:kalman@localhost:5432/TOGG', convert_unicode=True, echo=False, pool_size=20, max_overflow=0)
Base = declarative_base()
Base.metadata.reflect(engine, views=True)

# Define Tables

class Stations(Base):
    # __table__ = Base.metadata.tables['stations_w_il_ilce_t']
    __table__ = Base.metadata.tables['stations_w_il_ilce_t_temporary']

class CurrentStations(Base):
    # __table__ = Base.metadata.tables['stations_w_il_ilce_t']
    __table__ = Base.metadata.tables['current_charge_stations_summary']


# Init db 
db = SQLAlchemy(app)

# Init Marshmallow to wrap   
ma = Marshmallow(app)

# init schema for Stations
class StationsSchema(ma.Schema):
    sales_volu = fields.Float()
    sales_line = fields.Float()
    status = fields.Integer()   
    class Meta:
        fields = ('id', 'license_no', 'station_na', 'distributi', 'distrib_01', 'sales_line', 'sales_volu', 'status',  'sehir_adi', 'ilce_adi')

station_schema = StationsSchema()
stations_schema = StationsSchema(many=True)

# Init Schema for groupby results 
class groupByIlSchema(ma.Schema):
    toplam = fields.Float()
    sehir_adi = fields.String()
    ilce_adi = fields.String()
    adet = fields.Integer()
    class Meta:
        fields = ('id', 'sehir_adi', 'toplam', 'ilce_adi', 'adet')


group_by_Il_schema = groupByIlSchema()
group_by_Ils_schema = groupByIlSchema(many=True)


class groupByStatusSchema(ma.Schema):
    sales_volume_limited = fields.Integer()
    sales_volume_total_limited = fields.Integer()
    class Meta:
        fields = ('id', 'sales_volume_limited', 'sales_volume_total_limited')

group_by_status_schema = groupByStatusSchema()
group_by_statuses_schema = groupByStatusSchema(many=True)





class currentStationsSchema(ma.Schema):
    id = fields.Integer()
    column_name = fields.String()
    column_count = fields.Integer()
    column_capacity = fields.Integer()
    class Meta:
        fields = ('id', 'column_name', 'column_count', 'column_capacity')

current_station_schema = currentStationsSchema()
current_stations_schema = currentStationsSchema(many=True)

# define non route inner methods 
def getTotals(res, field):
    toplam = 0
    for r in res:
        for row in r.keys():
            if row == field:
                toplam = toplam +  r[row]
    return toplam

#Initiate DB session 
db_session = scoped_session(sessionmaker(bind=engine))

# Get All Stations
@app.route('/stations', methods=['GET'])
@cross_origin()
def getStations():
    stations = db_session.query(Stations).all()
    result = stations_schema.dump(stations)
    return jsonify(result)

# Get filtered Stations by status  
@app.route('/stations/<id>', methods=['GET'])
@cross_origin()
def getStationFiltered(id):
    stations = db_session.query(Stations).filter(Stations.status == int(float(id)))
    result = stations_schema.dump(stations)
    return jsonify(result)


stations_all = db_session.query(Stations).all()
result_all= stations_schema.dump(stations_all)
total_all = getTotals(result_all, "sales_volu")


# Get sum by sales volume
@app.route('/sales_volume/<ord>', methods=['GET'])
@cross_origin()
def getStationOrdered(ord):
    stations_limited = db_session.query(Stations).order_by(Stations.status.desc()).limit(ord).all()
    result_limited = stations_schema.dump(stations_limited)
    total_limited = getTotals(result_limited, "sales_volu")
    return jsonify({
        'sales_volume_total': total_all,
        'sales_volume_total_limited': total_limited,
        'sales_volume_limited': ord,
        'sales_volume_percentage' : (total_limited / total_all)*100
    })

# Get sum by sales volume according to status 
@app.route('/sales_volume/status/<stat>', methods=['GET'])
@cross_origin()
def getStationsByStat(stat):
   

    stations_limited = db_session.query(Stations).filter(Stations.status == int(float(stat)))
    result_limited = stations_schema.dump(stations_limited)
    total_limited = getTotals(result_limited, "sales_volu")
    return jsonify({
        'sales_volume_total': total_all,
        'sales_volume_total_limited': total_limited,
        'sales_volume_limited': stat,
        'sales_volume_percentage' : (total_limited / total_all)*100
    })

# Get sum by sales volume according to status and group by  
@app.route('/sales_volume/status/', methods=['GET'])
@cross_origin()
def getStationsByStatinGroups():
    stations_limited = db_session.query(Stations.status.label("sales_volume_limited"), func.Sum(Stations.sales_volu).label("sales_volume_total_limited")).group_by(Stations.status).all()  
    result_limited = group_by_statuses_schema.dump(stations_limited)
    for r in result_limited:
        r['sales_volume_percentage'] = 100*(r['sales_volume_total_limited']/ total_all)
        r['sales_volume_total'] = total_all
    return jsonify(result_limited)

# Get sum by sales volume according to each il  
@app.route('/sales_volume/il', methods=['GET'])
@cross_origin()
def getStationsByIl():
    stations_by_il = db_session.query(Stations.sehir_adi.label('sehir_adi'), func.sum(Stations.sales_volu).label("toplam"), func.count(Stations.license_no).label("adet")).group_by(Stations.sehir_adi).all()
    result_by_il = group_by_Ils_schema.dump(stations_by_il)
    for r in result_by_il:
	    r['percentage'] = 100*(r['toplam']/ total_all)
    return jsonify(result_by_il)

@app.route('/current_stations/summary', methods=['GET'])
@cross_origin()
def getcurrent_stations():
    current_stations = db_session.query(CurrentStations.id.label('id'), 
    CurrentStations.column_name.label('column_name'), 
    CurrentStations.column_count.label('column_count'), 
    CurrentStations.column_capacity.label('column_capacity')).order_by(CurrentStations.id.asc()).all()
    result = current_stations_schema.dump(current_stations)
    return jsonify(result)



# Get sum by sales volume according to each ilce  
@app.route('/sales_volume/ilce', methods=['GET'])
@cross_origin()
def getStationsByIlce():
    stations_by_ilce = db_session.query(Stations.sehir_adi.label('sehir_adi'),Stations.ilce_adi.label('ilce_adi'), func.sum(Stations.sales_volu).label("toplam"), func.count(Stations.license_no).label("adet")).group_by(Stations.sehir_adi, Stations.ilce_adi).all()
    result_by_ilce = group_by_Ils_schema.dump(stations_by_ilce)
    for r in result_by_ilce:
	    r['percentage'] = 100*(r['toplam']/ total_all)
    return jsonify(result_by_ilce)



@app.route('/', methods=['GET'])
def get():
    return jsonify(
        {
            'Status': 'OK',
            'Version':'0.1.2',
            'Copyright': 'MRC-TR',
            'Created By': 'KNN', 
            'Scope':'To get stations from Database',
            'Date Updated':datetime.datetime.strptime("20200526","%Y%M%d")})

# Run Server 
if __name__ == '__main__':
    app.run( host="10.27.130.79")
