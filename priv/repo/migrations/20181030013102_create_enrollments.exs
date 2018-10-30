defmodule EducationApi.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :cpf, :string
      add :enrollment, :string
      add :installments, :integer
      add :billingDay, :integer
      add :paymentMethod, :string
      timestamps()
    end

    create unique_index(:enrollments, [:cpf])

  end
end
