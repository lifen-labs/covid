# Covid

Covid is a web application which aims to facilitate covid-19 patients home monitoring via forms sent by SMS.

## Main configuration

### Installation

It's a Rails v6.0 application which runs on Ruby v2.6+.

It requires a limited number of dependencies to run locally:

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
gem install bundler
```

#### Git

```bash
git clone git@github.com:lifen-labs/covid.git && cd covid
bundle exec install && yarn install
bundle exec rails db:setup
```

#### Environment variables

```bash
cp .env.example .env
```

##### Twilio

We use Twilio's API to send SMS:
- `TWILIO_ACCOUNT_ID` (required)
- `TWILIO_AUTH_TOKEN` (required)
- `TWILIO_PHONE_NUMBER` (required)

##### Slack

We use Slack to monitor failed SMS:
- `SLACK_HOOK_URL` (optional)

#### Starting a local server

```bash
heroku local
```

Then [http://localhost:5000/admin/](http://localhost:5000/admin/) with the seeds credentials: `admin@example.com` / `password`.


#### Specs

```bash
bundle exec rspec spec/
```

or

```bash
bundle exec guard
```

## Deployment

The fastest way to deploy `covid` is using Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Data structure

An `AdminUser` can connect to the app via a login/password. He then can:
- manage a `CommandCenter` : this app can be deployed once and used in multiple localizations (TODO: add an authorization framework like pundit to manage different access levels through admin users)
- onboard a `Patient`
- manually create a `StandardSurvey` or wait for the automated standard survey creation process (one every 24 hours) to create one

When a `StandardSurvey` is created, a SMS is sent with a secret and temporary link. The `Patient` can fill in the form from his phone.
Once the `StandardSurvey` is submitted, the app sets the operationnal status :
- `green` : all good
- `yellow` : default status, still all good
- `orange` : a healthcare professional needs to check the survey results
- `red` : a healthcare professional needs to call the patient

Both `orange` and `red` statuses requires an action from the `AdminUser` which needs to be log (with a mandatory comment) via the app.

## Contributing

- submit a Pull Request on the `master` branch
- provid maximum context
- add the necessary specs to maintain a high test coverage


## License

Covid is licensed under the GNU Affero General Public License. See the included LICENSE file for details.