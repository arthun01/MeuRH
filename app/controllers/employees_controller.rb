class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ edit update destroy ]
  before_action :authorize_admin!, except: %i[ index update ]

  def index
    @employees = Employee.kept.includes(:role)
  end

  def export
    @employees = Employee.kept.includes(:role)
    
    require 'csv'
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["Nome", "CPF", "Idade", "Cargo", "Salário Base (R$)", "Bônus (R$)", "Salário Total (R$)", "Tempo de Serviço (Dias)"]
      @employees.each do |emp|
        tempo_servico = (Date.today - emp.created_at.to_date).to_i
        csv << [
          emp.name,
          emp.cpf,
          emp.age,
          emp.role&.title || "Sem Cargo",
          emp.role_base_salary || 0.0,
          emp.bonus_salary || 0.0,
          emp.total_salary,
          tempo_servico
        ]
      end
    end

    send_data csv_data, filename: "relatorio_funcionarios_#{Date.today}.csv"
  end

  def new
    @employee = Employee.new
    @employee.build_user
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)
    
    # Sync the name and company to the user account
    if @employee.user.present?
      @employee.user.name = @employee.name
      @employee.user.company = current_user.company
    end

    if @employee.save
      redirect_to employees_path, notice: "Funcionário criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # If not admin, the user can ONLY update their own status
    unless current_user.admin? || current_user.employee&.id == @employee.id
      redirect_to employees_path, alert: "Acesso negado."
      return
    end

    if params[:employee][:user_attributes].present? && params[:employee][:user_attributes][:password].blank?
      params[:employee][:user_attributes].delete(:password)
    end

    if @employee.update(employee_params)
      redirect_to employees_path, notice: "Funcionário atualizado com sucesso."
    else
      # If it's just a status update from index, we might want to redirect back
      redirect_to employees_path, alert: "Erro ao atualizar funcionário."
    end
  end

  def destroy
    @employee.discard
    redirect_to employees_path, notice: "Funcionário desativado com sucesso."
  end

  private

  def authorize_admin!
    unless current_user.admin?
      redirect_to employees_path, alert: "Apenas administradores podem realizar esta ação."
    end
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    if current_user.admin?
      params.require(:employee).permit(:name, :cpf, :age, :bonus_salary, :status, :role_id, user_attributes: [:id, :email, :password])
    else
      # Common employees can ONLY update their status
      params.require(:employee).permit(:status)
    end
  end
end
