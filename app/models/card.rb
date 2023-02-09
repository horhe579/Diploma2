class Card < ApplicationRecord
    validates :name, presence: true

    scope :ordered, -> { order(id: :asc) }

    belongs_to :company

    #after_create_commit -> { broadcast_prepend_later_to "cards" }
    #after_update_commit -> { broadcast_replace_later_to "cards" }
    #fter_destroy_commit -> { broadcast_remove_to "cards" }

    broadcasts_to ->(card) { [card.company, "cards"] }, insert_by: :prepend
end
