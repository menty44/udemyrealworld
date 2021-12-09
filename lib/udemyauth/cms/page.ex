defmodule Udemyauth.CMS.Page do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pages" do
    field :body, :string
    field :title, :string
    field :views, :integer
    belongs_to :author, Udemyauth.CMS.Author

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
