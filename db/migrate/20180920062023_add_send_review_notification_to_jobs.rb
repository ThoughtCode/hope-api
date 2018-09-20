class AddSendReviewNotificationToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :review_notification_send, :boolean, default: false
  end
end
