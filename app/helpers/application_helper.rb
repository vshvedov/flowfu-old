# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper

  def page_title
    h(@page_title || 'WORKFU')
  end

  def get_flash_messages
    msg = ''
    flash.each do |key, value|
      msg += content_tag(:div, content_tag(:p, value), :class => "msg msg-#{key}") if value.class == String
    end
    msg
  end

  def is_admin?
    current_user.is_admin?
  end
end
