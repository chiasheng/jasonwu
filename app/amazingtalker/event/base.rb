class Event::Base
  class << self
    def dispatch(current_user, **params)
      instance = new
      instance.bind_instance_variables(current_user, params)
      instance.run
    end

    def param(name, default = nil)
      @param_configure ||= {}
      @param_configure[name] = default
    end

    def param_configure
      @param_configure ||= {}
    end
  end

  def run
    @i18n = i18n
    channels.each do |channel|
      send("via_#{channel}")
    end
  end

  def bind_instance_variables(current_user, params)
    @current_user = current_user
    self.class.param_configure.each do |key, default|
      instance_variable_set("@#{key}", params[key] || default)
    end
  end

  private

  def via_telegram
    # send to telegram process ...
    print_mock_message(:telegram)
  end

  def via_email
    # send to email process ...
    print_mock_message(:email)
  end

  def via_sms
    # send to sms process ...
    print_mock_message(:sms, @current_user.mobile)
  end

  def translate(type)
    I18n.t("#{translate_key}.#{type}", **@i18n, locale: @current_user.locale)
  end

  def translate_key
    self.class.name.underscore.tr('/', '.')
  end

  def print_mock_message(type, device = nil)
    puts("[#{type}][#{device || @current_user.send(type)}] #{translate(type)}")
  end
end
