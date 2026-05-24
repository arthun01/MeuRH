class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @tasks = Task.all.order(created_at: :desc)
    else
      @tasks = current_user.employee&.tasks&.order(created_at: :desc) || []
    end
  end

  def show
  end

  def new
    authorize_admin!
    @task = Task.new
  end

  def create
    authorize_admin!
    @task = Task.new(task_params)
    @task.creator = current_user
    
    if params[:task][:tags].present?
      @task.tags = params[:task][:tags].to_s.split(',').map(&:strip).reject(&:blank?)
    end

    if @task.save
      redirect_to tasks_path, notice: 'Tarefa criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize_admin!
  end

  def update
    if current_user.admin?
      if params[:task][:tags].present?
        @task.tags = params[:task][:tags].to_s.split(',').map(&:strip).reject(&:blank?)
      end

      if @task.update(task_params)
        redirect_to tasks_path, notice: 'Tarefa atualizada com sucesso.'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      # Empregado atualiza apenas o status
      if @task.update(status: params[:task][:status])
        redirect_to tasks_path, notice: 'Status da tarefa atualizado.'
      else
        redirect_to tasks_path, alert: 'Erro ao atualizar a tarefa.'
      end
    end
  end

  def destroy
    authorize_admin!
    @task.destroy
    redirect_to tasks_path, notice: 'Tarefa removida com sucesso.'
  end

  private

  def set_task
    if current_user.admin?
      @task = Task.find(params[:id])
    else
      @task = current_user.employee.tasks.find(params[:id])
    end
  end

  def authorize_admin!
    unless current_user.admin?
      redirect_to tasks_path, alert: 'Acesso negado. Apenas administradores podem realizar esta ação.'
    end
  end

  def task_params
    if current_user.admin?
      params.require(:task).permit(:title, :description, :due_date, :status, employee_ids: [])
    else
      params.require(:task).permit(:status)
    end
  end
end
