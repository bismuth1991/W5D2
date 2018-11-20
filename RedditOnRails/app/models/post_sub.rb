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
  validates :post, :sub, presence: true
  validates :post_id, uniqueness: { scope: :sub_id, message: "Post cannot belong to same sub twice." }

  belongs_to :post
  belongs_to :sub
end