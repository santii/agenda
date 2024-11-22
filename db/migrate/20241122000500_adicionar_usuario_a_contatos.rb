class AdicionarUsuarioAContatos < ActiveRecord::Migration[7.2]
  def change
    add_reference :contatos, :usuario, null: false, foreign_key: true
  end
end
