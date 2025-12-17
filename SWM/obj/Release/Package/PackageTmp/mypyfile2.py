from flask import Flask, request

app = Flask(__name__)

@app.route('/python_script_endpoint', methods=['GET'])
def process_query_string():
    param1 = request.args.get('param1')
    param2 = request.args.get('param2')
    print(param1)
    
    # Process the parameters and return a response
    return f"Received query string parameters: param1={param1}, param2={param2}"

if __name__ == '__main__':
    app.run(host='localhost', port=8000)
