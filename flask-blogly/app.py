from flask import Flask, render_template, redirect, request
from models import db, connect_db, User



app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///blogly'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

connect_db(app)

#adding route for users/

@app.route("/users")
def list_users():
    """Show all users."""
    users = User.query.all()
    return render_template("list.html", users=users)

#adding route for users/new
@app.route("/users/new")
def show_add_user_form():
    """Show form to add a new user."""
    return render_template("new.html")

#add a form-handling route, POST /users/new

@app.route("/users/new", methods=["POST"])
def add_user():
    """Handle form submission for creating a new user."""
    first_name = request.form["first_name"]
    last_name = request.form["last_name"]
    image_url = request.form["image_url"].strip() or "https://cdn-icons-png.flaticon.com/512/149/149071.png"

    new_user = User(first_name=first_name,
                    last_name=last_name,
                    image_url=image_url)

    db.session.add(new_user)
    db.session.commit()

    return redirect("/users")

#show one user

@app.route("/users/<int:user_id>")
def show_user(user_id):
    """Show info about a single user."""
    user = User.query.get_or_404(user_id)
    return render_template("detail.html", user=user)

#editing users

@app.route("/users/<int:user_id>/edit")
def show_edit_form(user_id):
    """Show form to edit an existing user."""
    user = User.query.get_or_404(user_id)
    return render_template("edit.html", user=user)

#adding post route to handle update

@app.route("/users/<int:user_id>/edit", methods=["POST"])
def update_user(user_id):
    """Handle form submission for updating a user."""
    user = User.query.get_or_404(user_id)

    user.first_name = request.form["first_name"]
    user.last_name = request.form["last_name"]
    user.image_url = request.form["image_url"].strip() or "https://cdn-icons-png.flaticon.com/512/149/149071.png"

    db.session.commit()

    return redirect("/users")

#route to delete user

@app.route("/users/<int:user_id>/delete", methods=["POST"])
def delete_user(user_id):
    """Delete a user."""
    user = User.query.get_or_404(user_id)
    db.session.delete(user)
    db.session.commit()

    return redirect("/users")

# Only create tables if running this file directly
if __name__ == "__main__":
    with app.app_context():
        db.create_all()