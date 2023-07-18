ActiveAdmin.register User do
  permit_params :username, :email, :money, :encrypted_password, :remember_created_at

  remove_filter :encrypted_password, :remember_created_at
  filter :username
  filter :email
  filter :money
end
