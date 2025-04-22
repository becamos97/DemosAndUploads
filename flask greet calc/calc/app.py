from flask import Flask, request
from operations import add, sub, mult, div

app = Flask(__name__)

@app.route("/add")
def do_add():
    """add a and b parameters"""

    a = int(request.args.get("a"))
    b = int(request.args.get("b"))
    result = add(a, b)

@app.route("/sub")
def do_sub():
    """Subtract a and b parameters"""

    a = int(request.args.get("a"))
    b = int(request.args.get("b"))
    result = sub(a, b)

@app.route("/mult")
def do_mult():
    """Multiply a and b parameters"""

    a = int(request.args.get("a"))
    b = int(request.args.get("b"))
    result = mult(a, b)

@app.route("/div")
def do_div():
    """Divide a and b parameters"""

    a = int(request.args.get("a"))
    b = int(request.args.get("b"))
    result = div(a, b)


# Put your app in here.

operators = {
    "add": add,
    "sub": sub,
    "mult": mult,
    "div": div,
}

@app.route("/math/<oper>")
def do_math(oper):
    """Subtract a and b parameters"""

    a = int(request.args.get("a"))
    b = int(request.args.get("b"))
    result = operators[oper](a, b)

    return str(result)