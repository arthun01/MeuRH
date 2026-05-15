class RolesController < ApplicationController
  before_action :set_role, only: %i[ edit update destroy ]
  before_action :authorize_admin!

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to roles_path, notice: "Cargo criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @role.update(role_params)
      redirect_to roles_path, notice: "Cargo atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @role.destroy
      redirect_to roles_path, notice: "Cargo excluído com sucesso."
    else
      redirect_to roles_path, alert: @role.errors.full_messages.to_sentence
    end
  end

  private

  def authorize_admin!
    unless current_user.admin?
      redirect_to employees_path, alert: "Acesso negado."
    end
  end

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:title, :base_salary)
  end
end
