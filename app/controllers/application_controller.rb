class ApplicationController < ActionController::Base
  def register
    # registart process ...
    Event::User::Auth::Register.dispatch(current_user)
  end

  def book_appointment
    # book appointment process ...
    Event::Teacher::Appointment::BookedByStudent.dispatch(mock_appointment.teacher, appointment: mock_appointment)
  end

  def cancel_appointment
    # cancel appointment process ...
    Event::Teacher::Appointment::CancelByStudent.dispatch(mock_appointment.teacher, appointment: mock_appointment)
  end

  private

  def current_user
    @current_user ||= User.find_by(email: 'john@email.com')
  end

  def mock_appointment
    @mock_appointment ||= Appointment.first
  end

  def mock_teacher_user
    @mock_teacher_user ||= User.find_by(email: 'jane@email.com')
  end
end
