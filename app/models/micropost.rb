class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  has_many :commments
  private
   
    # 验证上传的图片大小
    def picture_size
      if picture.size > 30.megabytes
        errors.add(:picture, "上传图片应小于30MB")
      end
    end
end
