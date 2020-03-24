class AddUpperAndLowerSalaryToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :upper_salary, :integer, default: nil
    add_column :jobs, :lower_salary, :integer, default: nil
  end
end
