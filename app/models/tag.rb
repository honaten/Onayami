class Tag < ApplicationRecord
    validates :name, presence: true
    has_many :nayami_tag_relations, dependent: :destroy
    has_many :nayamis, through: :nayami_tag_relations, dependent: :destroy

end
