class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :province
      t.string :zip

      t.timestamps
    end
  end
end
