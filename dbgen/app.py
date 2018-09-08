import sys
import os

sys.path.append(os.path.join(os.getcwd(), "backend"))

from backend.api.app import init_and_generate
from backend.api.config import BaseConfig
from backend.api.models import db
from flask import Flask

def gen():
    app = Flask(__name__)
    app.config.from_object(BaseConfig)
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL')
    app.config['ID_LIST_FILE'] = './ids.json'
    app.config['DB_GEN_POLICY'] = 'always'
    app.config['DB_FORCE_INIT'] = False

    db.init_app(app)

    with app.app_context():
        init_and_generate()

if __name__ == '__main__':
    gen()
