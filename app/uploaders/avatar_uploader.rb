# encoding: utf-8
require "digest/md5"
class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :grid_fs
  process :convert => 'png'

  def store_dir
    "#{model.class.to_s.underscore}"
  end

  def default_url
      "/avatar/" + [version_name, "default.png"].compact.join('_')
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
    if original_filename 
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end

end