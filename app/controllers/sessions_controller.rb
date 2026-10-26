class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  def welcome
    if current_user
      if current_user.teacher?
        redirect_to teacher_lab_work_templates_path
      elsif current_user.student?
        redirect_to student_lab_works_path
      else
        redirect_to new_session_path
      end
    else
      redirect_to new_session_path
    end
  end
  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user

      if user.teacher?
        redirect_to teacher_lab_work_templates_path, notice: "Вітаємо, викладачу!"
      elsif user.student?
        redirect_to student_lab_works_path, notice: "Вітаємо, студенте!"
      else
        redirect_to root_path
      end
    else
      redirect_to new_session_path, alert: "Неправильна пошта або пароль."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, status: :see_other
  end
end