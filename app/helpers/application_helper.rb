module ApplicationHelper
  include Pagy::Frontend
  def sort_options
    %w[create_time end_time id priority].map do |key|
      [ Task.human_attribute_name(key), key ]
    end
  end

  def direction_options
    %w[asc desc].map do |key|
      [ Task.human_attribute_name(key), key ]
    end
  end

  def status_options
    Task.statuses.map do |key, value|
      [ I18n.t(key, scope: %i[activerecord attributes task statuses]), value ]
    end
  end

  def priority_options
    Task.priorities.map do |key, value|
      [ I18n.t(key, scope: %i[activerecord attributes task priorities]), value ]
    end
  end
end
