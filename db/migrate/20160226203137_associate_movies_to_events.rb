class AssociateMoviesToEvents < ActiveRecord::Migration
  def change
  	add_reference :movies, :event, index: true
  end
end
