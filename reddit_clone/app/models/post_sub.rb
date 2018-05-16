# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint(8)        not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ApplicationRecord
  validates :sub_id, uniqueness: {scope: :post_id}

  belongs_to :post,
  primary_key: :id,
  foreign_key: :post_id,
  class_name: :Post

  belongs_to :sub,
  primary_key: :id,
  foreign_key: :sub_id,
  class_name: :Sub

end
