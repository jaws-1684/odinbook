module ApplicationHelper
	require 'digest'
	require 'uri'
 
	def created_by_current_user? resource
		cookies[:current_user_id] == resource.user.id
	end

	def current_user_id
		cookies[:current_user_id] 
	end

	def post_msessage (profile, user = nil)
			user ||= current_user
      unless profile == user
        "User currently don’t have any posts."
      else
        "You currently don’t have any posts"  
      end
  end 

  
	def avatar_url(user, opts={})
		size = opts[:size] || 40
		email = "example@mail.com"
		begin
			return user.avatar.url if user.avatar.attached?
			return user.avatar_url if user.avatar_url.present?
			gravatar_for(user.email, size)
	  rescue  
      gravatar_for email,size
    end
    
 	end

 	def post_url post
 		begin
	 		if post.image.attached?
	    	image_tag(post.image.url, class: "w-full max-h-100")
	    elsif post.image_url.present?
	     	image_tag(post.image_url, class: "w-full")
	    else
	    	""  	
	    end
  	rescue
  		""
  	end
 	end

 	def default_gravatar
 		"https://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802?d=identicon"
 	end

 	private

 	def gravatar_for email, size
 		email_address = email.downcase
 		hash = Digest::SHA256.hexdigest(email_address)

 		default = "https://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802?d=identicon"
 		params = URI.encode_www_form('d' => default, 's' => size)
		image_src = "https://www.gravatar.com/avatar/#{hash}?#{params}"	
 	end


end


