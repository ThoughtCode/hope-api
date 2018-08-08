class Notification < ApplicationRecord
  enum status: [ :open, :new ]
  belongs_to :customer, optional: true
  belongs_to :agent, optional: true
  belongs_to :job, optional: true
end
