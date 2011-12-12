class AddExecutiveSummaryToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :executive_summary, :text
  end
end
