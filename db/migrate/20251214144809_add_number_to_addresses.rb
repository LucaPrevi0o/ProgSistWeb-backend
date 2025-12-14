class AddNumberToAddresses < ActiveRecord::Migration[8.1]
  def change
    add_column :addresses, :number, :string
  end
end
