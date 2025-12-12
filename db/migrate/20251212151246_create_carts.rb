class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true, null: true
      t.string :status, default: 'active', null: false

      t.timestamps
    end
  end
end
