defmodule Udemyauth.Repo.Migrations.ModifyForeignKeyPageV2 do
  use Ecto.Migration

  # def down do
  #   execute "ALTER TABLE pages DROP CONSTRAINT pages_author_id_index"
  #   alter table(:pages) do
  #     modify :author_id, references(:authors, on_delete: :delete_all),
  #     null: false
  #   end
  # end

  # def up do
  #   # execute "ALTER TABLE pages DROP CONSTRAINT pages_author_id_index"
  #   alter table(:pages) do
  #     modify :author_id, references(:authors, on_delete: :delete_all),
  #     null: false
  #   end
  #   create index(:pages, [:author_id])
  # end
end
