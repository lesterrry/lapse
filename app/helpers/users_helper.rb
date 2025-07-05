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

    def some_user_profile_picture(user, thumbnail: false)
        if user.profile_picture.attached?
            if thumbnail
                image_tag user.thumbnail_image(:profile_picture)
            else
                image_tag user.compressed_image(:profile_picture)
            end
        else
            image 'profile_mock.webp'
        end
    end
end
