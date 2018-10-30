defmodule EducationApiWeb.BillingController do
  use EducationApiWeb, :controller

  def create(conn, %{"installments" => installments, "enrollment_id" => enrollmentId}) do

    enrollment = EducationApi.Repo.get(EducationApi.Enrollment, enrollmentId)

    Enum.map(0..installments, fn(index) ->

      billingDate = calcBillingDate(%{ "billingDay" => enrollment.billingDay, "installmentIndex" => index })
      billing_changeset = Ecto.build_assoc(enrollment, :billings, billingNumber: index + 1, billingDate: billingDate, billingValue: 999.99, paymentMethod: "CREDIT" )

      case EducationApi.Repo.insert(billing_changeset) do
        {:ok, billing} -> conn |> put_status(:created)
        {:error, _changeset} -> json conn |> put_status(:bad_request), %{errors: ["Failed to create billing, invalid or duplicate data"] }
      end
    end)

  end

  def calcBillingDate(%{ "billingDay" => billingDay, "installmentIndex" => installmentIndex }) do

    todayDate = Timex.today
    today = Timex.day(todayDate)

    cond do
      today < billingDay -> Timex.shift(todayDate, months: installmentIndex)
      true -> Timex.shift(todayDate, months: installmentIndex + 1)
    end
  end

end
