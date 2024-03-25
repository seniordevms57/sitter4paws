class ServiceMailer < ApplicationMailer
    def service_email(user)
        @user = user
        mail(from: ENV['Mail_SENDING_FROM'], to: @user ? @user.email : ENV['GENERAL_CONTACT_EMAIL'], subject: 'New client registered!')
    end
end