module Tokenable

	extend ActiveSupport::Concern

  module ClassMethods

    def has_token(token_name, token_size = 8)

      token_column = "#{token_name}_token"

      validates_uniqueness_of token_column, allow_nil: true

      define_method "set_#{token_column}" do

        begin
          self.send("#{token_column}=", SecureRandom.hex[0..(token_size - 1)])
        end while self.class.exists?("#{token_column}" => self.send("#{token_column}"))

        save
      end
    end

  end

end