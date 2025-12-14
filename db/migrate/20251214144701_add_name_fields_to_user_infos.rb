class AddNameFieldsToUserInfos < ActiveRecord::Migration[8.1]
  def change
    add_column :user_infos, :last_name, :string
    add_column :user_infos, :first_name, :string
  end
end
