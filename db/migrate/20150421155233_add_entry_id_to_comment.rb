class AddEntryIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :entry_id, :integer
  end
end
