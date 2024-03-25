class UserMailer < ApplicationMailer
    def verify_email(user)
        @user = user
        mail(from: ENV['Mail_SENDING_FROM'], to: @user.email, subject: 'Verify your email address')
    end
end