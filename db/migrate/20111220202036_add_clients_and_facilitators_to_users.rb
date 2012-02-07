class AddClientsAndFacilitatorsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facilitator_id, :integer
  end
end
