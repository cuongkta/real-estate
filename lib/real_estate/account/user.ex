defmodule RealEstate.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias RealEstate.Account.User
  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email, message: "Email already taken")
    |> generate_encrypted_password()
  end

  defp generate_encrypted_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end
  defp generate_encrypted_password(changeset), do: changeset


  # def changeset(model, params \\ :empty) do
  #   model
  #   |> cast(params, @required_fields, @optional_fields)
  #   |> validate_format(:email, ~r/@/)
  #   |> validate_length(:password, min: 5)
  #   |> validate_confirmation(:password, message: "Password does not match")
  #   |> unique_constraint(:email, message: "Email already taken")
  #   |> generate_encrypted_password
  # end


  # defp generate_encrypted_password(current_changeset) do
  #   case current_changeset do

  #     %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
  #       put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
  #     _ ->
  #       current_changeset

  #     IEx.pry
    
  #   end
  # end

  # defimpl Poison.Encoder, for: Any do
  #   def encode(%{__struct__: _} = struct, options) do
  #     map = struct
  #           |> Map.from_struct
  #           |> sanitize_map
  #     Poison.Encoder.Map.encode(map, options)
  #   end

  #   defp sanitize_map(map) do
  #     Map.drop(map, [:__meta__, :__struct__])
  #   end
  # end

end
