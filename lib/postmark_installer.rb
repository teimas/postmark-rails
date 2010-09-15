require 'action_mailer'
require 'postmark'

module PostmarkInstaller
  extend self
  
  def auto_detect_and_install
    if ActionMailer::Base.respond_to?(:add_delivery_method)
      install_in_rails_3
    else
      install_in_rails_2
    end
  end
  
  def install_in_rails_2
    ActionMailer::Base.send(:include, PostmarkDeliveryMethod)
  end
  
  def install_in_rails_3
    ActionMailer::Base.add_delivery_method :postmark, Mail::Postmark, :api_key => nil
  end
  
end