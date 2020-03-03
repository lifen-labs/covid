class CommandCenter < ApplicationRecord
  has_many :patients, dependent: :nullify

  validates_presence_of :name, :city

  def to_s
    "#{name} — #{city}"
  end
end