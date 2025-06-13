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

    def some_user_profile_picture(user)
        if user.profile_picture.attached?
            image_tag user.profile_picture
        else
            image 'profile_mock.webp'
        end
    end
end
