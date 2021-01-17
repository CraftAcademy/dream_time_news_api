class ArticlesShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :sub_title, :content, :image, :created_at, :updated_at, :author, :premium

  def created_at
    object.created_at.strftime('%F')
  end

  def updated_at
    object.updated_at.strftime('%F')
  end

  def author
    object.author.email
  end

  def image
    return nil unless object.image.attached?
    object.image_path
  end
end
