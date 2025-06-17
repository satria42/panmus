from flask import Flask, request, Response
from PIL import Image
import pytesseract
import io
import json
import os

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
        text = pytesseract.image_to_string(image)

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

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
