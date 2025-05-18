from unittest import TestCase
from app import app
from models import db, User

# Use a separate test database
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///blogly_test'
app.config['SQLALCHEMY_ECHO'] = False
app.config['TESTING'] = True

# Disable Flask DebugToolbar in tests
app.config['DEBUG_TB_HOSTS'] = ['dont-show-debug-toolbar']

# db.drop_all()
# db.create_all()

with app.app_context():
    db.drop_all()
    db.create_all()

class UserRoutesTestCase(TestCase):
    """Tests for user routes."""

    def setUp(self):
        """Add sample user."""
        with app.app_context():
            User.query.delete()

            user = User(first_name="Testy", last_name="McTest", image_url=None)
            db.session.add(user)
            db.session.commit()
            self.user_id = user.id

        self.client = app.test_client()

    def tearDown(self):
        """Clean up any fouled transaction."""
        with app.app_context():
            db.session.rollback()

    def test_list_users(self):
        """Test GET /users shows user list."""
        resp = self.client.get("/users")
        html = resp.get_data(as_text=True)

        self.assertEqual(resp.status_code, 200)
        self.assertIn("Testy McTest", html)

    def test_show_user_detail(self):
        """Test GET /users/<id> shows user info."""
        resp = self.client.get(f"/users/{self.user_id}")
        html = resp.get_data(as_text=True)

        self.assertEqual(resp.status_code, 200)
        self.assertIn("Testy McTest", html)

    def test_add_user(self):
        """Test POST /users/new adds a new user."""
        data = {
            "first_name": "Jane",
            "last_name": "Doe",
            "image_url": ""
        }
        resp = self.client.post("/users/new", data=data, follow_redirects=True)
        html = resp.get_data(as_text=True)

        self.assertEqual(resp.status_code, 200)
        self.assertIn("Jane Doe", html)

    def test_delete_user(self):
        """Test POST /users/<id>/delete deletes a user."""
        resp = self.client.post(f"/users/{self.user_id}/delete", follow_redirects=True)
        html = resp.get_data(as_text=True)

        self.assertEqual(resp.status_code, 200)
        self.assertNotIn("Testy McTest", html)