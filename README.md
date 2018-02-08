A CRUD app, a Wikipedia replica, which allows users to create public and private Markdown-based wikis. It allows users to collaborate on wikis, and select either standard or premium role.

Tools: Ruby on Rails.
Demo: https://stormy-hamlet-76662.herokuapp.com/

Features:
1. The app allows users to sign up for a free account by providing a user name, password and email.
2. It allows users to sign in and out of Blocipedia.
3. A user with a standard account, can create, read, update, and delete public wikis.
4. It offers three user roles: admin, standard, or premium.
5. It updates database automatically with users and wikis.
6. It allows users to upgrade my account from a free to a paid plan.
7. A premium user can create private wikis.
8. A user can edit wikis using Markdown syntax.
9. A premium user can add and remove collaborators for my private wikis


Some things I learned in the Blocipedia project include how to:

* incorporate the Devise user gem into a Rails project to require users to verify their email when creating an account
* incorporate a Stripe account for processing payment information to upgrade from a standard to premium user
* build rules that allow only certain users to view and edit certain wikis
* utilize the Redcarpet gem so wikis on the site parse Markdown syntax.
