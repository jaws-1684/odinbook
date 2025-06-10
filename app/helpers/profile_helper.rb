module ProfileHelper
	def msg profile, user
      unless profile == user
        "User currently don’t have any friends."
      else
        "You currently don’t have any friends.(do you?)"  
      end
    end 
end
