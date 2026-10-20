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
  end
end