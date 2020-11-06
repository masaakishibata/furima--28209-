crumb :root do
  link "FURIMA/トップページ", root_path
end

crumb :new_item do
  link "FURIMA/トップページ/出品ページ", new_item_path
  parent :root
end

crumb :edit_item do
  link "FURIMA/トップページ/商品編集ページ", edit_item_path
  parent :root
end

crumb :item do
  link "FURIMA/トップページ/商品詳細ページ", item_path(:item_id)
  parent :root
end

crumb :item_search do
  link "FURIMA/検索商品ページ", item_search_items_path
  parent :root
end

crumb :orders do
  link "FURIMA/商品詳細ページ/商品購入ページ",  item_orders_index_path
  parent :root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).