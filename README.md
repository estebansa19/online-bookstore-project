# README

## 🚀 About This App

Hello!

This project is my solution to the Online Bookstore test :).


### 🌟 Tech overview

This project has been built with the latest tools in the Ruby and Rails ecosystem:

- **Ruby 3.3.0 (latest)**: Enjoy the increased performance, better error messages, and enhanced debugging capabilities of the latest Ruby version.

- **Rails 7.1.3.2 (latest)**: Enjoy the new powerful features of Rails 7. We can use Turbo & Stimulus.

- **PostgreSQL**: We are using PostgreSQL. A powerful, open source object-relational database system. With features such as JSONB support, parallel query execution, and improved indexing for optimal database management.

### 🛠️ Project Setup

Setting up and running the application is pretty straightforwared and easy. Follow these steps to get started:

1. **Configuring and creating sample records in the DB:**
- Execute the commands required:
  ```
  rails db:create
  rails db:migrate
  rails db:seed
  ```

  After this step, the DB should be ready for use and with sample data :).

2. **Install the gems:**
- Execute the following command:
  ```
  bundle install
  ```

3. **Install the NPM packages used:**
- Execute the following command:
  ```
  npm install
  ```

4. **Start the Application**:
- Execute the following command and the application should be running on port 3000:
  ```
  bin/dev
  ```

### 🧑‍💻 Using the application

- After the previous configuration, all the requirements to execute the application are done.
- The following flows should work without any problem:

1. You should be able to enter to the root path `/` of the application (here the books are displayed with their information).
2. Sign in and sign up.
3. Adding a book to the shopping cart (you must be logged to do this action).
4. You can access your shopping cart (you must be logged to do this action)
5. You can continue the process with a shopping cart and purchase it (you must be logged to do this action. Here is where the communication with the payment platform should be done, due to the limited time this communication is not implemented yet).
6. Access to the admin module (here we can manage the books that are shown in the project, you should have an admin account to access this module).

- Here are some sample users credentials that are created with the seeds to use the application:
  ```
  admin user
  email: admin@mail.com
  password: !Admin123

  normal user
  email: pepe1@mail.com
  password: !Test123
  ```

### ✅ Test suite

You can execute the test suite with the following command:
```
bundle exec rspec
```
All specs are passing and cover most of the application logic (system and integration test would be a great improvement).

### ⚙️ Improvements

There are a lot of improvements that could be made to this project, for instance:

- Using View Components to encapsulate reusable parts of the views.
- There is a lot of code in the specs that is not DRY and could be improved with `shared_examples`.
- The interfaces could be much better.
- System and integration tests to ensure the application is working well at a higher level.
- There are some code standars that are not met in the application.

And so on, due to the limited time it was not possible to cover all of this improvements 😿. However, the requirements are covered.
