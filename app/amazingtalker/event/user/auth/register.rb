class Event::User::Auth::Register < Event::Base
  def channels
    [:sms, :email]
  end

  def i18n
    {
      name: @current_user.name
    }
  end
end
