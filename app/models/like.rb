class Like < ApplicationRecord
  belongs_to :nayami
  belongs_to :user

  validates_uniqueness_of :nayami_id, scope: :user_id

end
