module Student
  class LabWorksController < ApplicationController
    before_action :require_login
    before_action :ensure_student!

    def index
      @lab_works = current_user.lab_works.includes(:lab_work_template)
    end

    def show
      @lab_work = current_user.lab_works.find(params[:id])
      @template = @lab_work.lab_work_template
    end

    def create
      template = LabWorkTemplate.find(params[:lab_work_template_id])
      @lab_work = current_user.lab_works.build(lab_work_template: template, status: "in_progress")

      if @lab_work.save
        redirect_to student_lab_works_path, notice: "Роботу розпочато!"
      else
        redirect_to student_lab_works_path, alert: "Помилка при створенні."
      end
    end

    def update
      @lab_work = current_user.lab_works.find(params[:id])

      if @lab_work.status == "completed" || @lab_work.status == "reviewed"
        redirect_to student_lab_work_path(@lab_work), alert: "Цю роботу вже здано, редагування неможливе." and return
      end

      @template = @lab_work.lab_work_template
      answers_params = params[:answers] || {}

      missing_required = @template.questions.any? do |question|
        question.required? && answers_params[question.id.to_s].blank?
      end

      if missing_required
        flash.now[:alert] = "Будь ласка, заповніть усі обов'язкові поля перед здачею роботи!"
        render :show, status: :unprocessable_entity and return
      end

      if @lab_work.update(status: "completed", answers: answers_params)
        redirect_to student_lab_works_path, notice: "Лабораторну роботу успішно здано!"
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def ensure_student!
      unless student?
        redirect_to root_path, alert: "Доступ заборонено."
      end
    end
  end
end