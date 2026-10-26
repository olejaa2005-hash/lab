module Teacher
  class LabWorksController < ApplicationController
    before_action :require_login
    before_action :ensure_teacher!

    def index
      @lab_works = LabWork.joins(:lab_work_template)
                          .where(lab_work_templates: { teacher_id: current_user.id })
    end

    def show
      @lab_work = LabWork.joins(:lab_work_template)
                         .where(lab_work_templates: { teacher_id: current_user.id })
                         .find(params[:id])
      @template = @lab_work.lab_work_template
    end

    def new
      @lab_work = LabWork.new(lab_work_template_id: params[:template_id])
      @templates = current_user.lab_work_templates
      @students = User.where(role: "student")
    end

    def create
      template_id = params[:lab_work][:lab_work_template_id]
      assign_to_all = params[:assign_to_all] == "1"

      if assign_to_all
        students = User.where(role: "student")

        if students.empty?
          redirect_to new_teacher_lab_work_path, alert: "У системі немає жодного студента!" and return
        end

        ActiveRecord::Base.transaction do
          students.each do |student|
            LabWork.find_or_create_by!(
              lab_work_template_id: template_id,
              student_id: student.id
            ) do |lw|
              lw.status = "assigned"
            end
          end
        end

        redirect_to teacher_lab_works_path, notice: "Лабораторну роботу успішно призначено ВСІМ студентам!"
      else
        @lab_work = LabWork.new(lab_work_params)
        @lab_work.status = "assigned" if @lab_work.status.blank?

        if @lab_work.save
          redirect_to teacher_lab_works_path, notice: "Лабораторну роботу успішно призначено студенту!"
        else
          @templates = current_user.lab_work_templates
          @students = User.where(role: "student")
          render :new, status: :unprocessable_entity
        end
      end
    end

    def update
      @lab_work = LabWork.joins(:lab_work_template)
                         .where(lab_work_templates: { teacher_id: current_user.id })
                         .find(params[:id])

      if @lab_work.update(status: params[:status])
        redirect_to teacher_lab_works_path, notice: "Статус роботи оновлено!"
      else
        redirect_to teacher_lab_work_path(@lab_work), alert: "Помилка оновлення статусу."
      end
    end

    private

    def ensure_teacher!
      unless teacher?
        redirect_to root_path, alert: "Доступ заборонено."
      end
    end

    def lab_work_params
      params.require(:lab_work).permit(:lab_work_template_id, :student_id)
    end
  end
end