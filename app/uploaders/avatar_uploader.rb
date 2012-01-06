# encoding: utf-8
require "digest/md5"
class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :file
  process :convert => 'png'

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
      "/default/avatar/" + [version_name, "default.png"].compact.join('_')
  end

  version :s32 do
    process :resize_to_fit => [32, 32]
  end
  
  version :s48 do
    process :resize_to_fit => [48, 48]
  end
 
  version :s120 do
    process :resize_to_fit => [120, 120]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "pic.#{file.extension}" if original_filename
  end

end