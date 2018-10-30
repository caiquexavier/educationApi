# EducationApi

Dependencies

  * Elixir/Pheonix
  * Runnning local PostgresSQL instance:
  * docker run --name educationApi -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## API Doc

  * Post Student
```
{
    "name": "OTHER",
    "email": "OTHER@domain.com",
    "cpf": "9999",
    "enem": "200",
    "documentFile": "data:image/jpeg;base64"
}
```
