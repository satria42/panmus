FROM python:3.11-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    libleptonica-dev \
    poppler-utils \
    && apt-get clean

# Set working dir
WORKDIR /app

# Copy requirements and app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# Default port
ENV PORT=5000

# Run using gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
