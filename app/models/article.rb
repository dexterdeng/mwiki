class Article < ActiveRecord::Base
  acts_as_taggable
  has_paper_trail :on => [ :create, :update, :destroy ]

  belongs_to :user

  def to_s
    name
  end
end
