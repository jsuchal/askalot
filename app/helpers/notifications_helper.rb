module NotificationsHelper
  def notification_icon_tag(notification, options = {})
    activity_icon_tag notification, notification_options(notification, options)
  end

  def notification_content(notification, options = {})
    activity_content notification, notification_options(notification, options)
  end

  def link_to_notification(notification, options = {}, &block)
    link_to_activity notification, notification_options(notification, options), &block
  end

  def link_to_notifications(notifications, options = {})
    count = notifications.unread.unscope(:limit, :offset).size
    body  = options.delete(:body) || t('notification.unread_x', count: count)
    url   = options.delete(:url)  || notifications_path

    link_to body, url, analytics_attributes(:notifications, :list, "#{count}-unread").deep_merge(options)
  end

  private

  def notification_options(notification, options = {})
    options[:mute] = lambda { |_| !notification.unread }
    options[:url]  = lambda { |url| notification.unread ? read_notification_path(notification, params: { r: url }) : url }
    options
  end
end
