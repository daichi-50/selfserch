# breadcrumbs.rb
crumb :root do
  link "TOP", root_path
end

crumb :user_new do
  link "登録", new_user_registration_path
  parent :root
end

crumb :user_sign_in do
  link "ログイン", new_user_session_path
  parent :root
end

crumb :user_show do |user|
  link "#{user.username}さんのページ", user_path(user)
  parent :root
end

crumb :user_index do
  link "懸賞金獲得ランキング", users_path
  parent :post_index
end

crumb :user_search do |post|
  link "懸賞金を贈る", search_users_path
  parent :post_show, post
end

crumb :user_favorite do |user|
  link "お気に入り", favorites_user_path(user)
  parent :user_show, user
end

crumb :post_index do
  link "手配書一覧", posts_path
  parent :root
end

crumb :post_new do
  link "手配書作成", new_post_path
  parent :post_index
end

crumb :post_show do |post|
  link "手配書", post_path(post)
  parent :post_index
end
