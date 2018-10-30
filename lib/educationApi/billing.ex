defmodule EducationApi.Billing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "billings" do
    field :billingDate, :date
    field :billingNumber, :integer
    field :billingValue, :float
    # FK
    field :enrollment_id, :id

    timestamps()
  end

  @doc false
  def changeset(billing, attrs) do
    billing
    |> cast(attrs, [:billingValue, :billingNumber, :billingDate])
    |> validate_required([:billingValue, :billingNumber, :billingDate])
  end
end
