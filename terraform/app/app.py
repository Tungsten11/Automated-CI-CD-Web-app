from flask import Flask
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)
REQUEST_COUNT = Counter('flask_app_requests_total',
                        'Total requests to Flask app')


@app.route('/')
def index():
    REQUEST_COUNT.inc()
    return "Hello from Flask with Prometheus metrics!"


@app.route('/metrics')
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)  # matches EXPOSE 80
