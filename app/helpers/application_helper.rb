module ApplicationHelper

  # Классы bootstrap для разных категорий flash-алертов
  def bootstrap_class_for(name)
    {
      success: "alert-success",
      danger: "alert-danger",
      notice: "alert-success",
      alert: "alert-danger"
    }[name.to_sym] || name
  end
end
