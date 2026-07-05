FROM python:3.11-slim

WORKDIR /app

# System deps — build-essential needed for some Python packages that compile from source
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python deps — requirements.txt pins CPU-only torch via --extra-index-url
# so pip never pulls the CUDA build (~1.2 GB saved)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["python", "app.py"]
