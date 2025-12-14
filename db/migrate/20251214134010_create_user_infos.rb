class CreateUserInfos < ActiveRecord::Migration[8.1]
  def change
    create_table :user_infos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :last_name
      t.string :first_name
      t.string :phone
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
