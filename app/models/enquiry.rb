class Enquiry < ActiveRecord::Base
   attr_accessible :name, :phone_no, :email, :course
end
