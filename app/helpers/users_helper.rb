module UsersHelper
    def some_user_name(user)
        user.username || user.email
    end
end
