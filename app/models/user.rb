class User < ActiveRecord::Base
  attr_accessible :email_id
  has_one :library
end
