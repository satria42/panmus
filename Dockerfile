FROM python:3.10-slim

# Install dependencies system
RUN apt-get update && \
    apt-get install -y tesseract-ocr libtesseract-dev libleptonica-dev && \
    apt-get clean

# Set workdir
WORKDIR /app

# Copy all
COPY . /app

# Install python deps
RUN pip install --no-cache-dir -r requirements.txt

# Expose port
EXPOSE 5000

# Command to run
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
