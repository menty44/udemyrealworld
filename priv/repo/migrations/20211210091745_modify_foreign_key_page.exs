defmodule Udemyauth.Repo.Migrations.ModifyForeignKeyPage do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE pages DROP CONSTRAINT pages_author_id_fkey"

    alter table(:pages) do
      modify :author_id, references(:authors, on_delete: :delete_all), null: false
    end
  end

  def down do
    execute "ALTER TABLE pages DROP CONSTRAINT pages_author_id_fkey"

    alter table(:pages) do
      modify :author_id, references(:authors, on_delete: :delete_all), null: false
    end
  end

  # def change do

  #   drop_if_exists index(:pages, [:author_id])
  #   alter table(:pages) do
  #     modify :author_id, references(:authors, on_delete: :delete_all),
  #     null: false
  #   end

  #   create index(:pages, [:author_id])
  # end
end
