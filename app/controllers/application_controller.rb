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
    @current_user ||= User.find_or_create_by(
      email: 'john@email.com',
      name: 'John Doe',
      phone: '0912345678',
      apple: 'apple_device_id',
      telegram: 'telegram_id',
      locale: 'zh-TW'
    )
  end

  def mock_appointment
    Appointment.find_or_create_by(
      user: current_suer,
      teacher: mock_teacher_user,
      start: '2045-01-01'.to_time
    )
  end

  def mock_teacher_user
    @mock_teacher_user ||= User.find_or_create_by(
      email: 'jane@email.com',
      name: 'Jane Doe',
      phone: '0987654321',
      apple: 'apple_device_id',
      telegram: 'telegram_id',
      locale: 'en'
    )
  end
end
