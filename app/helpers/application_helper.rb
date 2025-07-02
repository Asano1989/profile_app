module ApplicationHelper
  def page_title(page_title = "")
    base_title = "プロフィール作成＆共有アプリ"

    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
