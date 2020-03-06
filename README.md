# Covid

Covid is a web application which aims to facilitate covid-19 patients home monitoring via forms sent by SMS.

## Main configuration

### Prérequis

It's a Rails v6.0 application which runs on Ruby v2.6+.

It requires a limited number of dependencies:

- PostgreSQL (v10.4+)
- Redis (Sidekiq)
- Headless Chrome (integration specs)
- NodeJS v12 (LTS)

The best way to install them is to use [Homebrew](https://brew.sh/index_fr.html):

```bash
brew update
brew install rbenv ruby-build postgresql redis
brew cask install chromedriver
```

#### Ruby

```bash
rbenv install 2.6.5
```

### Installation

#### Git

```bash
git clone git@github.com:honestica/covid.git
cd covid
gem install bundler
bundle exec install
yarn install
bundle exec rails db:setup
```

#### Environment variables

```bash
cp .env.example .env
```

#### Twilio

We use Twilio's API to send SMS:
- `TWILIO_ACCOUNT_ID` (required)
- `TWILIO_AUTH_TOKEN` (required)
- `TWILIO_PHONE_NUMBER` (required)

#### Slack

We use Slack to monitor failed SMS:
- `SLACK_HOOK_URL` (optional)

#### Starting local server

```bash
heroku local
```

Then [http://localhost:5000/admin/](http://localhost:5000/admin/) with the following credentials: `admin@example.com` / `password`.


#### Specs

```bash
bundle exec rspec spec/
```

or

```bash
bundle exec guard
```

## Deployment

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)