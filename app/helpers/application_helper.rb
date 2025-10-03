module ApplicationHelper
  def sort_options
    %w[create_time end_time id].map do |key|
      [ key == "id" ? "ID" : I18n.t("activerecord.attributes.task.#{key}"), key ]
    end
  end

  def direction_options
    %w[asc desc].map do |key|
      [ I18n.t("activerecord.attributes.task.#{key}"), key ]
    end
  end
end
