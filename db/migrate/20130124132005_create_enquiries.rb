class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
     t.string  :name
     t.string :phone_no
     t.string  :email
     t.string  :course

      t.timestamps
    end
  end
end
