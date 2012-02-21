class AddCoverPageToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :cover_page, :text
  end
end
