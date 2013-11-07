# encoding: utf-8

class CoverUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIwAAACMCAYAAACuwEE+AAAFCklEQVR4Xu3Y50ubbRiG8SuKiAMFFRe4UBEnDlz4xT/dDy4coAgKbgUXatziTnvdkOBCPYmaphxCaTFn+7RHfu/9PHkj0Wg0ZnxR4IsFIoD5YilmoQBggCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVAIyUizFgMCAVSGswt7e3tri4aMfHx9bY2Gg1NTVv/vH++u7urtXV1Vl9fX14/fDw0FZXV81/f2FhobW0tFh2dvan4X77ep/+hVIwSFswNzc3NjU1ZVlZWXZ1dfUumLOzM5udnbWnp6cEmPv7exsbG7OcnBwrLS21jY0NKykpsY6Ojg/z//b1UmDhS5dMWzDX19fhZCkoKLDp6el3wTio/Pz8FyfMwcGBLSwsWGdnZ4DiJ9D+/r4NDw/b1taWra2tWXd3txUVFSVe6+/vt0gk8u3Xy8jI+NKb9C+N0hZMPOL5+Xk4aV7fknZ2dsKb39fXZ6Ojo4kTxk8U//7g4KDl5eXZ+vp6+DE0NBRuS/5nxWIxa25utpmZGWtoaLDa2trEe/ad1/NTLt2+/kswDw8PNj4+Ht5sv+2MjIwkwPizy+bmZgDib5j/2r83MDAQTqOLi4uAJjMz03Jzc623tzecLh8BTeZ6gPnlAu/9F7+8vGzRaNR6enrs8fExnDDV1dXhoXd7e/vFCeOnjZ86cUD+1/eT5fT01JqamqyqqurFv+gnrvfLyZK63H95wkxOTtrl5eWbMJWVlVZcXPziGcafZ46OjsIzjJ8k/glqfn4+3K78AdlvXf5g/dEJk8z1knr3UvCb0xbM3d2dnZycmH96WVlZsYqKivAQ6x+T/TU/WfzLf56bm7Py8vJwW/LnFD9xnn9KKisrs9bWVvNby8TERLg1+TOM/9pvaf7aT1wvBe930pdMWzCOxT8yv/5qb283BxD/cgTPn2H8+/7pym9b8f8P09bWFk6RpaUl29vbM/9U9PyBuKury/wTzXdfL+l3LwV/QNqCSUErLvm3AGBgIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBUAjJSLMWAwIBX4AzQ9H7USfB6dAAAAAElFTkSuQmCC'
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
   end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
