class AddNotNullConstraint < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :jti, false
  end
end
