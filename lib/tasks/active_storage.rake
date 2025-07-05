namespace :active_storage do
  desc 'Process existing images to create compressed variants'
  task compress: :environment do
    puts 'Processing existing images...'

    # Process user profile pictures
    puts 'Processing user profile pictures...'
    User.all.each do |user|
      if user.profile_picture.attached? && user.profile_picture.content_type.start_with?('image/')
        begin
          # Create web-optimized variant
          user.compressed_image(:profile_picture)
          # Create thumbnail variant
          user.thumbnail_image(:profile_picture)
          print '.'
        rescue => e
          puts "\nError processing profile picture for user #{user.id}: #{e.message}"
        end
      end
    end

    # Process period photos
    puts "\nProcessing period photos..."
    Period.all.each do |period|
      if period.photos.attached?
        period.photos.each do |photo|
          if photo.content_type.start_with?('image/')
            begin
              # Create web-optimized variant
              photo.variant(
                format: 'webp',
                saver: { quality: 80, strip: true },
                resize_to_limit: [1920, 1080]
              ).processed

              print '.'
            rescue => e
              puts "\nError processing photo #{photo.id} for period #{period.id}: #{e.message}"
            end
          end
        end
      end
    end

    puts "\nFinished processing existing images."
  end
end
