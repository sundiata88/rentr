class Listing < ActiveRecord::Base
  belongs_to :user
  #has_many :messages

  # The below code sets up this model to support file attachments.
 # The listed options include:
 # styles: a hash of file sizes which will automatically be created in addition to the original uncropped size.
 # default_url: a path template for any inaccessible images (Imagine a facebook profile with no photo, it shows the default image.)
 # path: a path template for all of our images to follow. The only thing stored in our database will be the filename this way.
 # s3_region: 'us-west-1' in this example, which is the code name for Northern California. Check your s3 bucket settings in the AWS console to see the region of your bucket, or just choose Northern California in your bucket settings and use `us-west-1` as the region.
 # :s3_credentials gets our environment variables in the below method, and plugs them in to give our app access to post to our bucket.

 has_attached_file :photo,
                    styles: { medium: "300x300#", thumb: "100x100#" },
                default_url: "/images/:style/missing.png",
                     :storage => :s3,
                     url: ":s3_domain_url",
                     path: "/:class/:attachment/:id_partition/:style/:filename",
                     s3_region: 'us-west-1',
                     :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

 def s3_credentials
   {
     :bucket => ENV["S3_BUCKET_NAME"],
     :access_key_id => ENV["S3_ACCESS_KEY_ID"],
     :secret_access_key => ENV["S3_SECRET_ACCESS_KEY"]
   }
 end

 # makes sure that the only type of file being uploaded is an image:
 validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end


 
