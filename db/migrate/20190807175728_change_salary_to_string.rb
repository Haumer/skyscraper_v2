class ChangeSalaryToString < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :salary
    add_column :jobs, :salary, :string
  end
end
