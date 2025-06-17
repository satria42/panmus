FROM python:3.11-slim

# Install dependencies dan bahasa Indonesia
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-ind \
    libtesseract-dev \
    libleptonica-dev \
    poppler-utils \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy dan install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy aplikasi
COPY app.py .

# Set default port
ENV PORT=5000

# Jalankan dengan Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
