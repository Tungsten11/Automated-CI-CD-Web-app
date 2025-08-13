FROM python:3.11-slim-bookworm

# Set working directory
WORKDIR /app

# Install system dependencies required for Python packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    libffi-dev \
    libssl-dev \
    python3-dev \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    curl \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements.txt
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose port 80
EXPOSE 80

# Start Flask app
CMD ["python", "app.py"]
