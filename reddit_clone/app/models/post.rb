# == Schema Information
#
# Table name: posts
#
#  id        :bigint(8)        not null, primary key
#  title     :string           not null
#  url       :string
#  content   :text
#  sub_id    :integer          not null
#  author_id :integer          not null
#

class Post < ApplicationRecord
  validates :title, presence: true
  validates :subs, length: {minimum: 1}

  belongs_to :author,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :User

  has_many :post_subs,
  primary_key: :id,
  foreign_key: :post_id,
  class_name: :PostSub,
  inverse_of: :post

  has_many :subs,
  through: :post_subs,
  source: :sub

end
