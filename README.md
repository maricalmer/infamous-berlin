<div align="center">
  <img src="https://res.cloudinary.com/dbpv82leg/image/upload/c_fill,g_auto,w_300/v1673965776/logo.png" />
</div>

### [InfamousBerlin.com](https://infamousberlin.herokuapp.com/), a web app facilitating project collaborations in Berlin’s art scene

## Description

The core function of infamousberlin.com is to connect local artists and help them collaborate on art projects. A registered user can:

- upload projects <img align="right" src="https://res.cloudinary.com/dbpv82leg/image/upload/c_scale,w_400/v1674052464/gridstack-feature.gif" />
- rearrange portfolio display (see demo ---> )
- crop project thumbnails
- add project members
- add job offers
- apply to job offers
- live chat with other users
- discover suggested art events
- ... etc

## Web App

InfamousBerlin is developed with Ruby and supported by the Rails framework. It follows the MVC pattern and the TDD practice, uses Active Record as an interface for a PostgreSQL database. Authentication is operated through Devise. Tests are written with RSpec. Assets are bundled with Webpack. Application is run on Heroku. Continuous Integration tests are run on Github Actions. Real-time chat supported by Action Cable, Websocket and Redis

![ruby](https://img.shields.io/badge/Ruby-3.1.3-F32C24?style=for-the-badge&logo=ruby&logoColor=white) ![Rails](https://img.shields.io/badge/Rails-6.0.3-C52F24?style=for-the-badge&logo=rubyonrails&logoColor=white) ![JavaScript](https://img.shields.io/badge/JavaScript-ES6-yellow?style=for-the-badge&logo=javascript&logoColor=white) ![SCSS](https://img.shields.io/badge/SCSS-3.5-BF4080?style=for-the-badge&logo=sass&logoColor=white) ![HTML](https://img.shields.io/badge/HTML-5-E34F26?style=for-the-badge&logo=html5&logoColor=white) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14.6-4764BE?style=for-the-badge&logo=postgresql&logoColor=white) ![Bootstrap](https://img.shields.io/badge/Bootstrap-5-7852B2?style=for-the-badge&logo=bootstrap&logoColor=white) ![FontAwesome](https://img.shields.io/badge/FontAwesome-5-528CD7?style=for-the-badge&logo=fontawesome&logoColor=white)

## JS Packages (non exhaustive)

[![js-autocomplete](https://img.shields.io/badge/js--autocomplete-1.0.4-yellow.svg)](https://yarnpkg.com/package/js-autocomplete) [![cropperjs](https://img.shields.io/badge/cropperjs-1.5.12-yellow.svg)](https://yarnpkg.com/package/cropperjs) [![flatpickr](https://img.shields.io/badge/flatpickr-4.6.9-yellow.svg)](https://yarnpkg.com/package/flatpickr) [![gridstack](https://img.shields.io/badge/gridstack-5.0.0-yellow)](https://yarnpkg.com/package/gridstack) [![typed.js](https://img.shields.io/badge/typed.js-2.0.12-yellow.svg)](https://yarnpkg.com/package/typed.js)

## Ruby gems (non exhaustive)

[![cloudinary](https://img.shields.io/badge/cloudinary-1.22.0-red.svg)](https://rubygems.org/gems/cloudinary) [![redis](https://img.shields.io/badge/redis-4.3.1-red.svg)](https://rubygems.org/gems/redis) [![pundit](https://img.shields.io/badge/pundit-2.2-red.svg)](https://rubygems.org/gems/pundit) [![simple_form](https://img.shields.io/badge/simple_form-5.1.0-red.svg)](https://rubygems.org/gems/simple_form) [![pg_search](https://img.shields.io/badge/pg_search-2.3.5-red.svg)](https://rubygems.org/gems/pg_search) [![rails_admin](https://img.shields.io/badge/rails_admin-3.1.1-red.svg)](https://rubygems.org/gems/rails_admin) [![active_analytics](https://img.shields.io/badge/active_analytics-0.2.1-red.svg)](https://rubygems.org/gems/active_analytics) [![rspec-rails](https://img.shields.io/badge/rspec--rails-5.1.2-red.svg)](https://rubygems.org/gems/rspec-rails) [![factory_bot_rails](https://img.shields.io/badge/factory_bot_rails-6.2.1-red.svg)](https://rubygems.org/gems/factory_bot_rails) [![capybara](https://img.shields.io/badge/capybara-3.38.0-red.svg)](https://rubygems.org/gems/capybara) [![selenium-webdriver](https://img.shields.io/badge/selenium--webdriver-4.7.1-red.svg)](https://rubygems.org/gems/selenium-webdriver) [![bullet](https://img.shields.io/badge/bullet-6.1.5-red.svg)](https://rubygems.org/gems/bullet)

## Run Locally

Clone the project

```bash
  git clone https://github.com/maricalmer/infamous-berlin.git my-project
```

Go to the project directory and remove git logs

```bash
  cd my-project
  rm -rf .git
```

Install dependencies

```bash
  bundle install
  yarn install
```

Create database with seeds

```bash
  rails db:create db:migrate db:seed
```

Start the server

```bash
  rails s
```

## Visit the page!

[InfamousBerlin.com](https://infamousberlin.herokuapp.com/)

## License

[MIT](https://choosealicense.com/licenses/mit/)
