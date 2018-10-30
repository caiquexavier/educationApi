defmodule EducationApi.Repo.Migrations.CreateBillings do
  use Ecto.Migration

  def change do
    create table(:billings) do
      add :billingValue, :float
      add :billingNumber, :integer
      add :billingDate, :date
      add :enrollment_id, references(:enrollments, on_delete: :delete_all)

      timestamps()
    end

    create index(:billings, [:enrollment_id])
  end
end
