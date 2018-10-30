defmodule EducationApiWeb.EnrollmentController do
  use EducationApiWeb, :controller

  def index(conn, %{"cpf" => cpf}) do
    enrollments = getEnrollmentByCpf(cpf)
    json build_response(conn, enrollments), enrollments
  end

  def create(conn, enrollmentRequest) do

    approval = checkApproval(conn, enrollmentRequest["cpf"])

    if approval === true do
      changeset = EducationApi.Enrollment.changeset(
       %EducationApi.Enrollment{}, enrollmentRequest)

       case EducationApi.Repo.insert(changeset) do
        {:ok, enrollment} ->

          EducationApiWeb.BillingController.create(conn, %{ "installments" => String.to_integer(enrollmentRequest["installments"]) -1, "enrollment_id" => enrollment.id})
          enrollment = enrollment |> EducationApi.Repo.preload(:billings)

          json conn |> put_status(:created), enrollment
        {:error, _changeset} ->
          json conn |> put_status(:bad_request), %{errors: ["Failed to create enrollment, invalid or duplicate data"] }
      end
    else
      json conn |> put_status(:bad_request), %{errors: ["student was not aprroved"] }
    end

  end

  def update(conn, %{"cpf" => cpf} = changes) do
    enrollment = getEnrollmentByCpf(cpf)
    changeset = EducationApi.Enrollment.changeset(enrollment, changes)

    case EducationApi.Repo.update(changeset) do
      {:ok, enrollment} ->
        json conn |> put_status(:ok), enrollment
      {:error, _result} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to update enrollment, payment method accepts {CREDIT | BANKSLIP}"]}
    end

  end

  defp getEnrollmentByCpf(cpf) do
    EducationApi.Enrollment
                  |> EducationApi.Repo.get_by(cpf: cpf)
                  |> EducationApi.Repo.preload(:billings)
  end

  defp checkApproval(conn, cpf) do
    student = EducationApi.Repo.get_by(EducationApi.Student, cpf: cpf)
    if student do
      student.approvalStatus
    else
      json conn |> put_status(:not_found), %{errors: ["unable to find student with this document"]}
    end
  end

  defp build_response(conn, nil) do
    conn
    |> put_status(:not_found)
  end

  defp build_response(conn, _) do
    conn
    |> put_status(:ok)
  end

end
