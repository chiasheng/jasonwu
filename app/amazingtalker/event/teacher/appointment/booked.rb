class Event::Teacher::Appointment::Booked < Event::Base
  param :appointment

  def channels
    [:email, :telegram]
  end

  def i18n
    {
      name: @current_user.name,
      student_name: @appointment.user.name,
      start_at: @appointment.start_at
    }
  end
end
