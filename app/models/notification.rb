class Notification < ApplicationRecord
  enum status: [ :opened, :created ]
  belongs_to :customer, optional: true
  belongs_to :agent, optional: true
  belongs_to :job

  scope :filter_by_status, -> (status) { where(status: status) }
end
