module Teacher
  class LabWorkTemplatesController < ApplicationController
    before_action :require_login
    before_action :ensure_teacher!

    def index
      @templates = current_user.lab_work_templates
    end

    def show
      @template = current_user.lab_work_templates.find(params[:id])
    end

    def new
      @template = current_user.lab_work_templates.build
      @template.questions.build
    end

    def create
      @template = current_user.lab_work_templates.build(template_params)

      if @template.save
        redirect_to teacher_lab_work_template_path(@template), notice: "Шаблон лабораторної роботи успішно створено!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def ensure_teacher!
      unless teacher?
        redirect_to root_path, alert: "Доступ заборонено."
      end
    end

    def template_params
      params.require(:lab_work_template).permit(
        :title,
        :description,
        questions_attributes: [:id, :content, :question_type, :required, :_destroy]
      )
    end
  end
end