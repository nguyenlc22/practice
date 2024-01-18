defmodule PhoenixSampleWeb.AuthController do
  @moduledoc """
    The User Controller
  """
  use PhoenixSampleWeb, :controller

  # import module
  alias PhoenixSample.Repo.User, as: UserRepo
  alias PhoenixSample.Schema.User, as: UserSchema
  alias PhoenixSampleWeb.Utils.Functional, as: UtilsFunc

  @doc """
    - REGISTER NEW ACCOUNT USER
      1. At time current for params (with 1 - admin role, 2 - user role)
      2. Get user with email from db for check user is exists
      3. Validate fields input params with changeset_register
      4. Hash password
      5. Insert user to databse
  """
  @elements [
    %{
      :title => "Email",
      :type => :text,
      :value => :email,
      :class => "form-control",
      :id => "card-body-email",
      :placeholder => "Enter your email address",
      :required => true
    },
    %{
      :title => "Name",
      :type => :text,
      :value => :name,
      :class => "form-control",
      :id => "card-body-name",
      :placeholder => "Enter your name",
      :required => false
    },
    %{
      :title => "Password",
      :type => :password,
      :value => :password,
      :class => "form-control",
      :id => "card-body-password",
      :placeholder => "Enter your password",
      :required => true
    },
    %{
      :title => "Password Confirm",
      :type => :password,
      :value => :password_confirmation,
      :class => "form-control",
      :id => "card-body-password-confirm",
      :placeholder => "Enter your password confirm",
      :required => true
    },
    %{
      :title => "Phone number",
      :type => :text,
      :value => :phone,
      :class => "form-control",
      :id => "card-body-phone",
      :placeholder => "Enter your phone number",
      :required => true
    }
  ]
  def new_register(conn, _params) do
    conn
    |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
    |> render("register.html", elements: @elements, msg_error: nil)
  end

  def register(conn, %{"user" => params}) do
    with params_at <- params
          |> Map.put("role", "user")
          |> Map.put("user_group_id", 2)
          |> Map.put("inserted_at", Calendar.DateTime.now!("Asia/Ho_Chi_Minh"))
          |> Map.put("updated_at", Calendar.DateTime.now!("Asia/Ho_Chi_Minh")),
        user_fetch <- UserRepo.get_user_by_email(params_at) do
          cond do
            is_nil(user_fetch) ->
              case UserRepo.create_user(params_at) do
                {:ok, user} ->
                  conn
                  |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
                  |> put_flash(:info, "Successfully Register Account")
                  |> render("success.html", msg_success: "Register success")
                {:error, %Ecto.Changeset{} = changeset} ->
                  conn
                  |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
                  |> render("register.html", elements: @elements, msg_error: "Something wrong from fields!")
                _ ->
                  conn
                  |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
                  |> render("server_error.html")
              end
            true ->
              conn
              |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
              |> render("register.html", elements: @elements, msg_error: "Email is already!")
          end
    else
      _ -> conn
        |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
        |> render("server_error.html")
    end
  end

  @doc """
    - LOGIN WITH EMAIL AND PASSWORD
      1. Get user with email
      2. Verify password
      3. Generate token
  """
  @elements_login [
    %{
      :title => "Email",
      :type => :text,
      :value => :email,
      :class => "form-control",
      :id => "card-body-email",
      :placeholder => "Enter your email address",
      :required => true
    },
    %{
      :title => "Password",
      :type => :password,
      :value => :password,
      :class => "form-control",
      :id => "card-body-name",
      :placeholder => "Enter your password",
      :required => true
    }
  ]

  def init_login(conn, _params) do
    conn
    |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
    |> render("login.html", elements: @elements_login, msg_error: nil)
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password} = params}) do
    with %UserSchema{} = user_fetch <- UserRepo.get_user_by_email(params),
          true <- UtilsFunc.op(:verify_password, Pbkdf2.verify_pass(password, user_fetch.password)),
          {:ok, token, claims} <- UtilsFunc.generate_token(%{
            "user_id" => user_fetch.id,
            "email" => user_fetch.email,
            "role" => user_fetch.role
          }) do
          IO.inspect(claims)
          # response
          conn
          |> put_session(:token, token)
          |> put_flash(:info, "Successfully logged in")
          |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
          |> redirect(to: Routes.admin_path(conn, :index))
    else
      {:verify_password, _error} ->
        conn
        |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
        |> put_flash(:info, "Password is wrong!")
        |> render("login.html", elements: @elements_login, msg_error: "Password is wrong!")
      _ -> conn
        |> put_layout({PhoenixSampleWeb.LayoutView, :auth})
        |> render("server_error.html")
    end
  end
end
