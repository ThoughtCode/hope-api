class AddServiceRefToPromotion < ActiveRecord::Migration[5.1]
  def change
    add_reference :promotions, :service, foreign_key: true
  end
end
