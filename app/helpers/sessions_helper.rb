module SessionsHelper
	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		current_user = user
	end

	# This is a setter method.
	def current_user=(user)
		@current_user = user
	end

	# This is a getter method.
	def current_user
		@current_user ||= user_from_remember_token
	end

	# This bit put in so the "it should sign the user in" test will pass.

	  def signed_in?
	    !current_user.nil?
	  end

	private

		def user_from_remember_token
			User.authenticate_with_salt(*remember_token)
		end

		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
		end
end