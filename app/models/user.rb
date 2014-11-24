class User < ActiveRecord::Base
	has_many :photos
	has_many :cards
	has_many :banks
	has_secure_password

	validates :firstname,
		presence: true
	validates :lastname,
		presence: true
	validates :username,
		uniqueness: true,
		presence: true
	validates :password,
		presence: true,
		length: {minimum: 5},
		on: :create
	validates :email,
		uniqueness: true,
		presence: true
end
