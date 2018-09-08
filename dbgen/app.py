from backend.api.app import init_and_generate
from flask import Flask

def gen():
    app = Flask(__name__)
    app.config.from_pyfile('config.cfg')
    app.config['DB_GEN_POLICY'] = 'always'
    app.config['DB_FORCE_INIT'] = True

    with app.app_context():
        init_and_generate()
