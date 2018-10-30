defmodule EducationApi.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :email, :string
      add :cpf, :string
      add :enem, :integer
      add :documentFile, :binary
      add :approvalStatus, :boolean
      timestamps()
    end

    create unique_index(:students, [:cpf])

  end
end
