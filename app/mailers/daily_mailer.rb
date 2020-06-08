class DailyMailer < ApplicationMailer
	default from: ENV["USER_NAME"]

	def notify_user
		mail(
			subject: "定期配信。",
			to: User.pluck(:email)
			) do |format|
			format.text
		end
	end
end
