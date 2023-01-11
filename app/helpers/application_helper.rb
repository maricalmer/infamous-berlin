module ApplicationHelper
  def cloud_name
    # "dbpv82leg"
    ENV["CLOUDINARY_CLOUD_NAME"]
  end
end
