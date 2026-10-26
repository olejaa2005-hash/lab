module Teacher
  class LabWorkTemplatesController < ApplicationController
    before_action :require_login
    before_action :ensure_teacher!
    before_action :set_template, only: %i[show edit update destroy]

    def index
      @templates = current_user.lab_work_templates
      @lab_work_templates = current_user.lab_work_templates
    end

    def show
    end

    def new
      @template = current_user.lab_work_templates.build
      @template.questions.build
    end

    def edit
      @template.questions.build if @template.questions.empty?
    end

    def create
      @template = current_user.lab_work_templates.build(template_params)

      if params[:add_question].present?
        @template.questions.build
        render :new, status: :unprocessable_entity
      elsif @template.save
        redirect_to teacher_lab_work_template_path(@template), notice: "Шаблон лабораторної роботи успішно створено!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      # Якщо натиснули кнопку додавання питання під час редагування
      if params[:add_question].present?
        # Спочатку призначаємо нові параметри (щоб не втратити вже введені дані), потім додаємо питання
        @template.assign_attributes(template_params)
        @template.questions.build
        render :edit, status: :unprocessable_entity
      elsif @template.update(template_params)
        redirect_to teacher_lab_work_template_path(@template), notice: "Шаблон успішно оновлено!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @template.destroy
      redirect_to teacher_lab_work_templates_path, notice: "Шаблон лабораторної роботи видалено."
    end

    private

    def set_template
      @template = current_user.lab_work_templates.find(params[:id])
    end

    def ensure_teacher!
      unless current_user&.teacher?
        if current_user&.student?
          redirect_to student_lab_works_path, alert: "Доступ заборонено. Тільки для викладачів."
        else
          redirect_to new_session_path, alert: "Будь ласка, увійдіть в систему."
        end
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