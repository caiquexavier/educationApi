defmodule EducationApi.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :name, :string
    field :email, :string
    field :cpf, :string
    field :enem, :integer
    field :documentFile, :binary
    field :approvalStatus, :boolean
    timestamps()
  end

  def changeset(student, params \\ %{}) do
    student
    |> cast(params, [:name, :email, :cpf, :enem, :documentFile, :approvalStatus])
    |> validate_required([:name, :email, :cpf, :approvalStatus])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:cpf)
  end

end
