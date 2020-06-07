# Preview all emails at http://localhost:3000/rails/mailers/thanks_mailer
class ThanksMailerPreview < ActionMailer::Preview

	 # http://localhost:3000/rails/mailers/thanks_mailer/send_thanks_to_user
	def send_thanks_to_user
		user = User.first
		ThanksMailer.send_thanks_to_user(user)
	
	end

end
