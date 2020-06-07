class ThanksMailer < ActionMailer::Base
	default from: ENV["USER_NAME"]

	def send_thanks_to_user(user)
		@user = user
		mail(
			subject: "会員登録完了しました。",
			to: @user.email
			) do |format|
			format.text
		end
	end
end
