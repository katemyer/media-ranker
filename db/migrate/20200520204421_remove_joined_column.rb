class RemoveJoinedColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :joined
    #future ref if need to add
    #add_column :table_name, :column_name, :datatype
  end
end
