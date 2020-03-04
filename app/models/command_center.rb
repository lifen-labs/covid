class CommandCenter < ApplicationRecord
  has_many :patients, dependent: :nullify

  validates_presence_of :name, :city, :phone_number

  def to_s
    "#{name} — #{city}"
  end
end