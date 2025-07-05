# Configure ActiveStorage to use variants for image compression
Rails.application.config.after_initialize do
  Rails.application.config.active_storage.variant_processor = :mini_magick
end
