class DashboardController < ApplicationController
  def index
    unless current_user.admin?
      redirect_to employees_path
      return
    end
    @employees = current_user.company.employees.kept.includes(:role)
    @roles_count = current_user.company.roles.count
    
    total_salary = @employees.sum(&:total_salary)
    @average_salary = @employees.any? ? (total_salary / @employees.count.to_f) : 0
  end
end
