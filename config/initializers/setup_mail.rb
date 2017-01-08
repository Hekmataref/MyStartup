ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "googlemail.com",
    :user_name            => "hekmataref@gmail.com",
    :password             => "secret_password",
    :authentication       => "plain",
    :enable_starttls_auto => true
}