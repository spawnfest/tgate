# Tgate

## Description

MVP of service for sending verification codes through telegram (instead of sms)

User registers in the system and creates a project.

After the project created it's owner can add new abonents to it. The abonent will start with `pending` status and must confirm it's identity in telegram bot by
entering confirmation code that owner will see when the abonent added to the project.

Abonents with `pending` status can't receive codes in telegram bot.

Command in telegram bot for abonent to confirm it's identity:

```
/confirm <CONFIRMATION_CODE>
```

Owner can refresh confirmation code if abonent didn't confirm it's identity in
30 secs.

After abonent identity is confirmed, owner can request code for abonent to be sent 
in telegram. Code verification takes place on owner side and not handled by the service.

If code send failed than abonent will change it's status to `deactivated`. 
In that case reactivation of abonent will be required.

Owner can also deactivate abonent manually at any time.

For convenience seeds containing test user, test project and test abonent created already.

## Up and running

1. Install Postgresql 15.0
2. [Obtain telegram bot API token](https://core.telegram.org/bots/tutorial#obtain-your-bot-token)
3. Copy example secrets:

```sh
cp .env.example .env
```
4. Put `BOT_TOKEN` FROM second step in `.env` file
5. Setup database:

```sh
mix ecto.setup
```

6. Up system

```
source .env && iex -S mix phx.server
```

Now you can navigate to [project showcase page](http://127.0.0.1:4000/)
