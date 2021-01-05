class ArticlesIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :sub_title, :content, :created_at, :updated_at, :author 

  def created_at
    object.created_at.strftime("%F")
  end

  def updated_at
    object.updated_at.strftime("%F")   
  end

  def author
    object.author.email
  end
end
