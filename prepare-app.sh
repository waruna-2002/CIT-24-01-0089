#!/bin/bash
echo "Preparing app..."

# 1. Network eka create karaganna
docker network create app-net 2>/dev/null || true

# 2. Persistent Volume eka create karaganna (Data save wenna)
docker volume create redis-data

# 3. Simple Python Flask App container image eka build karaganna
cat << 'EOF' > Dockerfile
FROM python:3.9-slim
WORKDIR /app
RUN pip install flask redis
COPY app.py .
CMD ["python", "app.py"]
EOF

cat << 'EOF' > app.py
from flask import Flask
import redis

app = Flask(__name__)
# Redis container ekata connect wenawa
r = redis.Redis(host='redis-db', port=6379, decode_responses=True)

@app.route('/')
def index():
    # Page count eka increment karala save karagannawa
    count = r.incr('hits')
    return f"<h1>Welcome!</h1><p>This page has been viewed <b>{count}</b> times.</p>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

docker build -t my-web-app .
echo "App prepared successfully!"