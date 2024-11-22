class CreateUsuarios < ActiveRecord::Migration[7.2]
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :token

      t.timestamps
    end
  end
end
