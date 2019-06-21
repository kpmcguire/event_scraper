class KpmFormBuilder < ActionView::Helpers::FormBuilder

  def text_field(method, options = {})
    super(method, insert_class("input", options))
  end

  def label(method, text = nil, options = {}, &block)
    super(method, text, insert_class("label", options), &block)
  end

  def submit(method, options = {}, &block)
    super(method, insert_class("button", options), &block)
  end  

  private

  def insert_class(class_name, options)
    output = options.dup
    output[:class] = ((output[:class] || "") + " #{class_name}").strip
    output
  end
end
