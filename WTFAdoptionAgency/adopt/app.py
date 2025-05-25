from flask import Flask, render_template, redirect, flash
from flask_debugtoolbar import DebugToolbarExtension
from models import db, Pet
from forms import AddPetForm, EditPetForm

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///adopt'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'abc123'
app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False

debug = DebugToolbarExtension(app)

db.init_app(app)

with app.app_context():
    db.create_all()


#routing home

@app.route("/")
def list_pets():
    """Homepage: list all pets."""

    pets = Pet.query.all()
    return render_template("home.html", pets=pets)

#showing and handling addpet form

@app.route("/add", methods=["GET", "POST"])
def show_add_pet_form():
    """Show and handle add-pet form."""

    form = AddPetForm()

    if form.validate_on_submit():
        name = form.name.data
        species = form.species.data
        photo_url = form.photo_url.data or None
        age = form.age.data
        notes = form.notes.data

        new_pet = Pet(
            name=name,
            species=species,
            photo_url=photo_url,
            age=age,
            notes=notes
        )

        db.session.add(new_pet)
        db.session.commit()
        flash(f"Added {new_pet.name}!")

        return redirect("/")

    return render_template("add_pet_form.html", form=form)

#Edit-Form Page!

@app.route("/<int:pet_id>", methods=["GET", "POST"])
def show_edit_pet(pet_id):
    """Show pet details and edit form."""

    pet = Pet.query.get_or_404(pet_id)
    form = EditPetForm(obj=pet)

    if form.validate_on_submit():
        pet.photo_url = form.photo_url.data
        pet.notes = form.notes.data
        pet.available = form.available.data

        db.session.commit()
        flash(f"Updated {pet.name}")
        return redirect(f"/{pet_id}")

    return render_template("edit_pet.html", pet=pet, form=form)


#this is to be able to run it in python

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(debug=True)
