class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id


      if user.role == "teacher"
        redirect_to teacher_lab_work_templates_path, notice: "Успішний вхід викладача!"
      else
        redirect_to student_lab_works_path, notice: "Успішний вхід студента!"
      end
    else
      flash.now[:alert] = "Невірний email або пароль"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Ви вийшли із системи."
  end
end