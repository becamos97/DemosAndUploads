from flask import Flask, render_template, redirect, request
from models import db, connect_db, User, Post, Tag, PostTag



app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///blogly'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

connect_db(app)

@app.route("/")
def root_redirect():
    return redirect("/users")

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

#add new post route

@app.route("/users/<int:user_id>/posts/new")
def show_add_post_form(user_id):
    user = User.query.get_or_404(user_id)
    tags = Tag.query.all()
    return render_template("add_post.html", user=user, tags=tags)

#handling the new post 

@app.route("/users/<int:user_id>/posts/new", methods=["POST"])
def handle_post_form(user_id):
    """Handle form to add a new post."""
    user = User.query.get_or_404(user_id)
    title = request.form["title"]
    content = request.form["content"]

    # Grab selected tag IDs from the form
    tag_ids = [int(tag_id) for tag_id in request.form.getlist("tags")]
    tags = Tag.query.filter(Tag.id.in_(tag_ids)).all()

    # Create the post and assign tags
    post = Post(title=title, content=content, user=user, tags=tags)

    db.session.add(post)
    db.session.commit()

    return redirect(f"/users/{user.id}")

#this is the route to the post

@app.route("/posts/<int:post_id>")
def show_post(post_id):
    """Show a single post."""
    post = Post.query.get_or_404(post_id)
    return render_template("post_detail.html", post=post)

#GET route for editing the post

@app.route("/posts/<int:post_id>/edit")
def edit_post_form(post_id):
    """Show form to edit an existing post and its tags."""
    post = Post.query.get_or_404(post_id)
    tags = Tag.query.all()  #checkboxes are rendering
    return render_template("edit_post.html", post=post, tags=tags)

#POST route for editing the post

@app.route("/posts/<int:post_id>/edit", methods=["POST"])
def handle_edit_form(post_id):
    """Handle form submission for updating a post and tags."""
    post = Post.query.get_or_404(post_id)
    post.title = request.form["title"]
    post.content = request.form["content"]

    # Handle tags
    tag_ids = [int(tag_id) for tag_id in request.form.getlist("tags")]
    post.tags = Tag.query.filter(Tag.id.in_(tag_ids)).all()

    db.session.commit()
    return redirect(f"/posts/{post.id}")


#delete post route!!

@app.route("/posts/<int:post_id>/delete", methods=["POST"])
def delete_post(post_id):
    """Delete the post and redirect to the user's page."""
    post = Post.query.get_or_404(post_id)
    user_id = post.user_id  # save before deleting

    db.session.delete(post)
    db.session.commit()

    return redirect(f"/users/{user_id}")

#listing all tags

@app.route("/tags")
def list_tags():
    """Show list of all tags."""
    tags = Tag.query.all()
    return render_template("tags/list.html", tags=tags)

#showing details about tags

@app.route("/tags/<int:tag_id>")
def show_tag(tag_id):
    """Show detail about a tag. Have links to edit form and to delete."""
    tag = Tag.query.get_or_404(tag_id)
    return render_template("tags/detail.html", tag=tag)

#form for new tag

@app.route("/tags/new")
def show_tag_form():
    """Show form to add a new tag."""
    return render_template("tags/new.html")

#creating tag

@app.route("/tags/new", methods=["POST"])
def create_tag():
    """Handle form submission for creating a new tag."""
    name = request.form["name"]

    existing = Tag.query.filter_by(name=name).first()
    if existing:
        flash(f"Tag '{name}' already exists!", "error")
        return redirect("/tags")

    tag = Tag(name=name)
    db.session.add(tag)
    db.session.commit()
    return redirect("/tags")

#form for editing tag

@app.route("/tags/<int:tag_id>/edit")
def show_edit_tag_form(tag_id):
    """Show edit form for a tag."""
    tag = Tag.query.get_or_404(tag_id)
    return render_template("tags/edit.html", tag=tag)

#process tag edit

@app.route("/tags/<int:tag_id>/edit", methods=["POST"])
def handle_edit_tag(tag_id):
    """Process edit form, edit tag, and redirects to the tags list."""
    tag = Tag.query.get_or_404(tag_id)
    tag.name = request.form["name"]
    db.session.commit()
    return redirect("/tags")

#deleting tag

@app.route("/tags/<int:tag_id>/delete", methods=["POST"])
def delete_tag(tag_id):
    """Delete a tag."""
    tag = Tag.query.get_or_404(tag_id)
    db.session.delete(tag)
    db.session.commit()
    return redirect("/tags")


# Only create tables if running this file directly
if __name__ == "__main__":
    with app.app_context():
        db.create_all()