class AddConversationIdToMessage < ActiveRecord::Migration[7.2]
  def change
    add_column :messages, :conversation_id, :string
  end
end
