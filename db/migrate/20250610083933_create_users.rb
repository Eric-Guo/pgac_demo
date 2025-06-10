class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :fingerprint

      t.timestamps
    end
    add_reference :messages, :user, null: false, foreign_key: true
  end
end
