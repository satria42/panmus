from flask import Flask, request, Response
import pytesseract
from PIL import Image
import io
import json

app = Flask(__name__)

@app.route('/ocr', methods=['POST'])
def ocr():
    if 'image' not in request.files:
        return Response(
            json.dumps({'error': 'No image uploaded'}) + "\n",
            status=400,
            mimetype='application/json'
        )

    try:
        file = request.files['image']
        image = Image.open(file.stream)
        text = pytesseract.image_to_string(image, lang='ind')

        result = {'text': text.strip()}
        return Response(
            json.dumps(result) + "\n",
            status=200,
            mimetype='application/json'
        )
    except Exception as e:
        return Response(
            json.dumps({'error': str(e)}) + "\n",
            status=500,
            mimetype='application/json'
        )
