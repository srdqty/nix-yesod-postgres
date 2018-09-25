# Yesod Postgres Template With Nix

This template is based on the stack yesod-postgres template.

## TODO

* Test building docker image

## Database Setup

### Initialize Postgres

We have some nix derivations with shell hooks for interacting with Postgres.

Execute the script below to do the following in order:
  * Initialize tmp/pgdata as your db storage directory.
  * Start Postgres
  * Create user "nix-yesod-postgres" with password "nix-yesod-postgres"
  * Create dev database "nix-yesod-postgres"
  * Create test database "nix-yesod-postgres_test"
  * Stop Postgres

```
nix-shell --pure nix/scripts/postgres-init.nix
```

### Start Postgres

```
nix-shell --pure nix/scripts/postgres-start.nix
```

### Stop Postgres

```
nix-shell --pure nix/scripts/postgres-stop.nix
```

### Run psql

Dev database (default).

```
nix-shell --pure  nix/scripts/run-psql.nix
```

Test database.

```
nix-shell --pure  nix/scripts/run-psql.nix --argstr database nix-yesod-postgres_test
```

## Development

See [nx/README.md](nix/README.md) as well.

Start a development server (with ghcid):

```
./run-dev-server.sh
```

As your code changes, your site will be automatically recompiled and redeployed to localhost.

## Tests

Run tests once:

```
./run-tests.sh
```

Run tests automatically in the background (with ghcid):

```
./run-background-tests.sh
```

## Yesod Documentation

* Read the [Yesod Book](https://www.yesodweb.com/book) online for free
* The [Yesod cookbook](https://github.com/yesodweb/yesod-cookbook) has sample code for various needs

## Yesod Help

* Ask questions on [Stack Overflow, using the Yesod or Haskell tags](https://stackoverflow.com/questions/tagged/yesod+haskell)
* Ask the [Yesod Google Group](https://groups.google.com/forum/#!forum/yesodweb)
* There are several chatrooms you can ask for help:
	* For IRC, try Freenode#yesod and Freenode#haskell
	* [Functional Programming Slack](https://fpchat-invite.herokuapp.com/), in the #haskell, #haskell-beginners, or #yesod channels.
