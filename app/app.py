# app.py

import os

import boto3

from flask import Flask, jsonify, request
app = Flask(__name__)

client = boto3.client('dynamodb', region_name='us-east-1')
dynamoTableName = 'musicTable'

@app.route("/")
def hello():
    return "Hello World!"


@app.route("/v1/bestmusic/90s/<string:artist>")
def get_artist(artist):
    resp = client.get_item(
        TableName=dynamoTableName,
        Key={
            'artist': { 'S': artist }
        }
    )
    item = resp.get('Item')
    if not item:
        return jsonify({'error': 'Artist does not exist'}), 404

    return jsonify({
        'artist': item.get('artist').get('S'),
        'song': item.get('song').get('S')
    })


@app.route("/v1/bestmusic/90s", methods=["POST"])
def create_artist():
    artist = request.json.get('artist')
    song = request.json.get('song')
    if not artist or not song:
        return jsonify({'error': 'Please provide Artist and Song'}), 400

    resp = client.put_item(
        TableName=dynamoTableName,
        Item={
            'artist': {'S': artist },
            'song': {'S': song }
        }
    )

    return jsonify({
        'artist': artist,
        'song': song
    })


if __name__ == '__main__':
    app.run(threaded=True,host='0.0.0.0',port=5000)

