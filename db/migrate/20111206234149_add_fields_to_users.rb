class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_name, :string
    add_column :users, :job_title, :string
    add_column :users, :street_address, :string
    add_column :users, :city, :string
    add_column :users, :zipcode, :string
    add_column :users, :state, :string
  end
end
