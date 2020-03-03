# Covid

Covid est une application qui a pour objectif de faciliter le suivi à domicile des patients atteints du covid-19.

## Configuration générale

### Prérequis

Il s'agit d'une application Rails v6.0 qui tourne avec Ruby v2.6.

Un nombre limité de dépendances externes doivent être configurées :

- PostgreSQL (v10.4+)
- Redis (Sidekiq)
- Headless Chrome (tests d'intégration)
- NodeJS v12 (LTS)

Il est conseillé d'utiliser [Homebrew](https://brew.sh/index_fr.html) pour installer ces dépendances :

```bash
brew update
brew install rbenv ruby-build postgresql redis
brew cask install chromedriver
```

#### Ruby

Vous pouvez ensuite installer Ruby via le manager de versions [rbenv](https://github.com/rbenv/rbenv) (la lecture de [cet article](http://octopress.org/docs/setup/rbenv/) est vivement conseillée pour effectuer les modifications nécessaires à votre `.bash_profile`)

```bash
rbenv install 2.6.5
```

Enfin il est conseillé d'avoir installé les éléments additionels d'Xcode (via `xcode-select --install`)

### Installation

#### Git

La première étape consiste à cloner le repo Github:

```bash
git clone git@github.com:honestica/poc-parcours.git
cd poc-parcours
gem install bundler
bundle exec install
yarn install
bundle exec rails db:setup
```

#### Variables d'environnement

L'application nécessite la configuration de certaines variables d'environnement pour fonctionner correctement. Ces informations ne sont pas versionnées pour des raisons évidentes.

La version staging de l'application étant hébergée sur Heroku nous utilisons la commande `heroku local` pour lancer le serveur de développement ([plus d'informations](https://devcenter.heroku.com/articles/heroku-local)). Pour définir vos propres variables il sera nécessaire de suivre les commandes suivantes :

```bash
cp .env.example .env
```

#### Lancement du serveur de développement

```bash
heroku local
```

Puis [http://localhost:5000/admin/](http://localhost:5000/admin/) et de vous connecter avec les identifiants présents dans le fichier de seeds : `admin@example.com` / `password`.


#### Lancement des tests

```bash
bundle exec rspec spec/
```

ou

```bash
bundle exec guard
```