defmodule EducationApi.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "enrollments" do
    field :cpf, :string
    field :enrollment, :string
    field :installments, :integer
    field :billingDay, :integer
    field :paymentMethod, :string
    has_many :billings, EducationApi.Billing
    timestamps()
  end

  @doc false
  def changeset(enrollment, attrs) do
    enrollment
    |> cast(attrs, [:cpf, :enrollment, :installments, :billingDay, :paymentMethod])
    |> validate_required([:cpf, :enrollment, :installments, :billingDay, :paymentMethod])
    |> validate_inclusion(:paymentMethod, ["CREDIT", "BANKSLIP"])
    |> unique_constraint(:cpf)

  end
end
