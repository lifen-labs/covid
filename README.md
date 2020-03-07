# Covid

Covid is a web application which aims to facilitate covid-19 patients' self-monitoring at home via forms sent by SMS.

**Demo :** [video](https://www.youtube.com/watch?v=wwDJNR6SKmI)

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

Then visit [http://localhost:5000/admin/](http://localhost:5000/admin/) with the seeds credentials: `admin@example.com` / `password`.


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

:warning: **Disclaimer** Heroku might not be suitable to host healthcare datas in your country. We are providing this deploy link on Heroku because we think it's the easiest way to deploy a web application ;) :warning:

## Data structure

Once signed in to the app via login/password, an `AdminUser` can:
- manage a `CommandCenter` : the app can be deployed once and used in multiple locations (TODO: add an authorisation framework like Pundit to manage access levels)
- onboard a `Patient`
- manually create a `StandardSurvey`; otherwise, an automated process creates one every 24 hours.

When a `StandardSurvey` is created, an SMS is sent with a secret temporary link. The `Patient` can then fill the form directly on his phone.
Once the `StandardSurvey` is submitted, the app sets the operational status :
- `green` : all good
- `yellow` : default status, still all good
- `orange` : a healthcare professional needs to check the survey results
- `red` : a healthcare professional needs to call the patient

Both `orange` and `red` statuses require an action from the `AdminUser`. Each action has to be recorded through a mandatory comment within the app.

## Contributing

Find details for contributing in the [contribution guide].

[contribution guide]: https://github.com/lifen-labs/covid/blob/master/CONTRIBUTING.md

## Maintainers

* Etienne Depaulis (https://github.com/EtienneDepaulis)

## License

Covid is licensed under the GNU Affero General Public License. See the included LICENSE file for details.
