# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise :registerable,
    :database_authenticatable,
    :recoverable, :rememberable,
    :trackable,
    :validatable
  # , :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
