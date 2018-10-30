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

## API Routes Examples

* You can use the project generated POSTMAN Collection by importing educationApi.postman_collection.json into your POSTMAN Workspace.

* POST Student (http://localhost:4000/api/v1/students/)
@RequestBody
```
{
  "name": "john",
  "email": "john@domain.com",
  "cpf": "12345678912",
  "enem": "200",
  "documentFile": "data:image/jpeg;base64 (Here you put you base64 imageFile String)"
}
```
* GET Student (http://localhost:4000/api/v1/students/:cpf)

* POST Enrollments (http://localhost:4000/api/v1/enrollments/)
@RequestBody
```
{
  "cpf": "12345678912",
  "enrollment": "ERL12345678912",
  "installments": "12",
  "billingDay": "31",
  "paymentMethod": "BANKSLIP"
}
```

* PUT Enrollment (http://localhost:4000/api/v1/enrollments/cpf)
@RequestBody
```
{
    "cpf": "39771673831",
    "paymentMethod": "CREDIT"
}
```

* GET Enrollment (http://localhost:4000/api/v1/enrollments/cpf)
