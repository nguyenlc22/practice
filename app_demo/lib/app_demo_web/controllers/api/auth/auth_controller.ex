defmodule AppDemoWeb.Api.PageController do
  @moduledoc """
    The API User Controller
  """
  use AppDemoWeb, :controller

  alias AppDemo.Repo.User, as: UserRepo
  alias AppDemo.Schema.User, as: UserSchema
  alias AppDemoWeb.Utils.Functional, as: UtilsFunc

  @doc """
    - REGISTER NEW ACCOUNT USER
      1. At time current for params (with 1 - admin role, 2 - user role)
      2. Get user with email from db for check user is exists
      3. Validate fields input params with changeset_register
      4. Hash password
      5. Insert user to databse
  """
  def register(conn, params) do
    with params_at <- params
          |> Map.put("user_group_id", 1)
          |> Map.put("inserted_at", Calendar.DateTime.now!("Asia/Ho_Chi_Minh"))
          |> Map.put("updated_at", Calendar.DateTime.now!("Asia/Ho_Chi_Minh")),
        user_fetch <- UserRepo.get_user_by_email(params_at) do
          cond do
            is_nil(user_fetch) ->
              case UserRepo.create_user(params_at) do
                {:ok, user} ->
                  conn |> render("response.json", %{statusCode: 200, message: "Register success.", data: user})
                {:error, %Ecto.Changeset{} = changeset} ->
                  conn |> render("response.json", %{statusCode: 400, message: "Something wrong from fields!", data: %{}})
                _ -> conn |> render("response.json", %{statusCode: 500, message: "Internal server error!", data: %{}})
              end
            true ->
              conn |> render("response.json", %{statusCode: 400, message: "Email is already!", data: %{}})
          end
    else
      _ -> conn |> render("response.json", %{statusCode: 500, message: "Internal server error!", data: %{}})
    end
  end

  @doc """
    - LOGIN WITH EMAIL AND PASSWORD
      1. Get user with email
      2. Verify password
      3. Generate token
  """
  def login_with_email(conn, %{"email" => email, "password" => password} = params) do
    with %UserSchema{} = user_fetch <- UserRepo.get_user_by_email(params),
        true <- UtilsFunc.op(:verify_password, Pbkdf2.verify_pass(password, user_fetch.password)),
        {:ok, token, claims} <- UtilsFunc.generate_token(%{
          "user_id" => user_fetch.id,
          "email" => user_fetch.email
        }) do
        IO.inspect(claims)
        # response
        conn |> render("response.json", %{statusCode: 200, message: "Login success.", data: %{"token" => token}})
    else
      {:verify_password, _error} ->
        conn |> render("response.json", %{statusCode: 400, message: "Password is wrong!", data: %{}})
      _ -> conn |> render("response.json", %{statusCode: 500, message: "Internal server error!", data: %{}})
    end
  end
end
