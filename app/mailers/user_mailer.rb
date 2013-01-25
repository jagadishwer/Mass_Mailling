class UserMailer < ActionMailer::Base
  default :from=> "from@example.com"
   def mass_email(user_name,user_email,subject,message)
 @message=message
 @user = user_name
    @url  = "http://example.com/login"
    mail(:to => "#{@user}<#{user_email}>",
         :subject => subject
        )
  end
end
