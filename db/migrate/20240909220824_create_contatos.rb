class CreateContatos < ActiveRecord::Migration[7.2]
  def change
    create_table :contatos do |t|
      t.string :nome
      t.string :telefone
      t.string :email

      t.timestamps
    end
  end
end
