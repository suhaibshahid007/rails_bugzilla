# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def manager?
    type == 'Manager'
  end

  def developer?
    type == 'Dev'
  end

  def qa?
    type == 'Qa'
  end
end
