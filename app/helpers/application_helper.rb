module ApplicationHelper
  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("", "", class: "uk-alert-close uk-close") + message, class: "uk-alert uk-alert-#{type}", :"data-uk-alert" => '')
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end
end
