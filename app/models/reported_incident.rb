class ReportedIncident < ApplicationRecord
    has_many :comment, dependent: :destroy
end
