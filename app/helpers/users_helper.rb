module UsersHelper
    def some_user_name(user)
        if !user.first_name.blank? && !user.last_name.blank?
            "#{user.first_name} #{user.last_name}"
        elsif !user.first_name.blank?
            user.first_name
        elsif !user.last_name.blank?
            user.last_name
        elsif !user.username.blank?
            user.username
        elsif !user.email.blank?
            user.email
        end
    end
end
