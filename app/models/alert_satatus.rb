class AlertSatatus
  AletType = {
      success: 'success',
      warning: 'warning',
      danger: 'danger',
      notice: 'info',
      info: 'info',
      completed: 'info'
  }

  def self.get_alart_type(type)
    AlertSatatus::AletType[type] || ''
  end

end