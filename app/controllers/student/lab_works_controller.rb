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

      if @lab_work.update(status: "completed")
        redirect_to student_lab_works_path, notice: "Лабораторну роботу успішно здано!"
      else
        @template = @lab_work.lab_work_template
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