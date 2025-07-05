module ImageCompressible
  extend ActiveSupport::Concern

  # Returns a web-optimized variant of the attached image
  # For single attachments (has_one_attached)
  def compressed_image(attachment_name)
    attachment = send(attachment_name)
    return nil unless attachment.attached?

    # Only process images
    return attachment unless attachment.content_type.start_with?('image/')

    # Create web-optimized variant directly
    attachment.variant(
      format: 'webp',
      saver: { quality: 80, strip: true },
      resize_to_limit: [1920, 1080]
    )
  end

  # Returns web-optimized variants for all attached images
  # For multiple attachments (has_many_attached)
  def compressed_images(attachment_name)
    attachments = send(attachment_name)
    return [] unless attachments.attached?

    attachments.map do |attachment|
      # Only process images
      if attachment.content_type.start_with?('image/')
        attachment.variant(
          format: 'webp',
          saver: { quality: 80, strip: true },
          resize_to_limit: [1920, 1080]
        )
      else
        attachment
      end
    end
  end

  # Returns a thumbnail variant of the attached image
  # For single attachments (has_one_attached)
  def thumbnail_image(attachment_name)
    attachment = send(attachment_name)
    return nil unless attachment.attached?

    # Only process images
    return attachment unless attachment.content_type.start_with?('image/')

    # Create thumbnail variant directly
    attachment.variant(
      format: 'webp',
      saver: { quality: 70, strip: true },
      resize_to_fill: [300, 300]
    )
  end
  
  # Returns web-optimized variants for a collection of attachments
  # For collections that aren't directly attached to the model
  def compressed_collection(attachments)
    return [] if attachments.empty?
    
    attachments.map do |attachment|
      # Only process images
      if attachment.content_type.start_with?('image/')
        attachment.variant(
          format: 'webp',
          saver: { quality: 80, strip: true },
          resize_to_limit: [1920, 1080]
        )
      else
        attachment
      end
    end
  end
end
