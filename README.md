# README

# Employee Onboarding Portal

A Ruby on Rails application for managing employee onboarding with features such as OAuth login (Google), Two-Factor Authentication (2FA), task tracking, and role-based access control (RBAC).

## Features

- **User Authentication**: Registration, login, and logout using Devise, with support for Google OAuth login.
- **Two-Factor Authentication (2FA)**: After login, users must enter an OTP (sent to their email) to complete the login process.
- **Role-Based Access Control (RBAC)**: Role management using the `cancancan` gem to differentiate between employees and HR users.
- **Task Tracking**: HR users can create and assign tasks to employees, while employees can mark tasks as completed and upload required documents.
- **Email Notification**: MailCatcher is used to intercept and view emails locally, such as OTP and other notifications.

## Requirements

Ensure you have the following installed on your system:

- [Ruby 3.1.2](https://www.ruby-lang.org/en/documentation/installation/)
- [Rails 7.0.x](https://guides.rubyonrails.org/v7.0/getting_started.html)
- [SQLite](https://www.sqlite.org/download.html) (for database)
- [Node.js](https://nodejs.org/en/download/) and [Yarn](https://yarnpkg.com/getting-started/install)
- [MailCatcher](https://mailcatcher.me/) for email testing
- [Google OAuth credentials](https://console.cloud.google.com/) (for OAuth login)

## Setup

### 1. Clone the Repository

    git clone <repository url>
    cd employee-onboarding-portal

### 2. Install Dependencies

  Install Ruby gems:

    bundle install

  Install JavaScript dependencies:

    yarn install

### 3. Setup Database

  Create and migrate the database:

    rails db:create
    rails db:migrate
    rails db:seed

### 4. Google OAuth Setup

  To enable Google OAuth login, you need to create a Google API project and get OAuth credentials:

    Go to the Google Cloud Console
    Create a new project
    Enable the Google+ API and OAuth Consent Screen
    Create OAuth credentials for a Web application

  Update devise.rb file with the Google OAuth credentials:
    config.omniauth :google_oauth2, <client_id>, <client_secret>

### 5. Precompile assets
    rails assets:precompile

### 6. Start MailCatcher:
    mailcatcher

  Visit http://127.0.0.1:1080 to view the intercepted emails.

### 7. Start the Rails Server
    rails server
  Visit the application at http://localhost:3000.
