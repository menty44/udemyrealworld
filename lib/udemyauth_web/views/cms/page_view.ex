defmodule UdemyauthWeb.CMS.PageView do
  use UdemyauthWeb, :view
  alias Udemyauth.CMS

  def author_name(%CMS.Page{author: author}) do
    author.user.name
  end
end
