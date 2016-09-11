module ApplicationHelper
  def bootstrap_flash
    alert_types = [:danger, :info, :success, :warning]
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?
      type = case type.to_sym
          when :notice
            :success
          when :alert, :error
            :danger
          else
            type
          end
      next unless alert_types.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                           content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                           msg, :class => "alert fade in alert-#{type}", data: {dismiss: "alert"})
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def error_message_in_html(m)
    html = ""
    # html += "<p class='error_title'>您提交的信息有如下错误:</p>"
    html += "<ul>"
    m.errors.full_messages.each do |msg|
      html += "<li>#{msg}</li>"
    end
    html += "</ul>"
  end

  def no_record_hint(set, msg="目前尚没有记录")
    content_tag(:div, msg, class: "alert fade in alert-info no-record-hint") if set.size == 0
  end
end
