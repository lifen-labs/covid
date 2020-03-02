class Patient < ApplicationRecord
  validates_presence_of :first_name, :last_name, :cellphone_number

  phony_normalize :cellphone_number, default_country_code: 'FR'
end
