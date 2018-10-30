defmodule EducationApiWeb.Router do
  use EducationApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", EducationApiWeb do
  #   pipe_through :browser # Use the default browser stack
  #
  #   get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.
  scope "/api/v1/", EducationApiWeb do
    pipe_through :api
    # Students Api
    get "/students", StudentController, :index
    get "/students/:cpf", StudentController, :get
    post "/students", StudentController, :create
    # Enrollments Api
    get "/enrollments/:cpf", EnrollmentController, :index
    post "/enrollments", EnrollmentController, :create
    put "/enrollments/:cpf", EnrollmentController, :update
  end
end
