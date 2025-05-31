class RemoveContentFromMessages < ActiveRecord::Migration[7.2]
  def change
    remove_column :messages, :content, :text
  end
end