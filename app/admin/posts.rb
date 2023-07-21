ActiveAdmin.register Post do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :image, :title, :description, :prize_money, :generated_card
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :image, :title, :description, :prize_money, :generated_card]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
