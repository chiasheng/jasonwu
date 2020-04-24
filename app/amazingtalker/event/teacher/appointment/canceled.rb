class Event::Teacher::Appointment::Canceled < Event::Base
  param :appointment

  def channels
    [:email, :apple, :telegram]
  end

  def i18n
    {
      name: @current_user.name,
      student_name: @appointment.user.name,
      start_at: @appointment.start_at
    }
  end
end
