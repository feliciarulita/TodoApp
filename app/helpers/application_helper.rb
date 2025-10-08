module ApplicationHelper
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
end
