defmodule EducationApiWeb.StudentController do
  use EducationApiWeb, :controller

  def index(conn, _params) do
    students = EducationApi.Repo.all(EducationApi.Student)
    json build_response(conn, students), students
  end

  def get(conn, %{"cpf" => cpf}) do
    student = EducationApi.Repo.get_by!(EducationApi.Student, cpf: cpf)
    json build_response(conn, student), student
  end

  def create(conn, student) do
    valuedStudent = approve(student)

    changeset = EducationApi.Student.changeset(
     %EducationApi.Student{}, valuedStudent)

     case EducationApi.Repo.insert(changeset) do
      {:ok, student} ->
        json conn |> put_status(:created), student
      {:error, _changeset} ->
        json conn |> put_status(:bad_request), %{errors: ["Failed to create student, invalid or duplicate data"] }
    end

  end

  defp approve(student) do
    cond do
      String.to_integer(student["enem"]) >= 450 && checkImageExt(student["documentFile"])  -> Map.put(student, "approvalStatus", "true")
      true -> Map.put(student, "approvalStatus", "false")
    end
  end

  defp checkImageExt(documentFile) do
      fileExtRegex = Regex.run(~r/data:image\/jpg/, documentFile) ||
        Regex.run(~r/data:image\/png/, documentFile) ||
        Regex.run(~r/data:image\/jpeg/, documentFile) ||
        Regex.run(~r/data:image\/pdf/, documentFile)

      if fileExtRegex do
        true
      else
        false
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
