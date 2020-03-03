class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_enum_name(enum_name, enum_value)
    return '' if enum_value.blank?

    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_method_name(enum_name)}.#{enum_value}")
  end

  def self.enum_filter_collection(enum_name)
    send(enum_method_name(enum_name)).inject({}) do |result, (key, _)|
      result.merge!(human_enum_name(enum_name, key) => key)
    end
  end

  def self.enum_method_name(enum_name)
    enum_name.to_s.pluralize
  end

end
