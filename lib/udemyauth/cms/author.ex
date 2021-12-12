defmodule Udemyauth.CMS.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :bio, :string
    field :role, :string
    has_many :pages, Udemyauth.CMS.Page
    belongs_to :user, Udemyauth.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:bio, :role])
    |> validate_required([:bio, :role])

    # |> unique_constraint(:user_id)
  end
end
