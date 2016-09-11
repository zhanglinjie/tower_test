module ActionBtnHelper
  def new_btn(record_or_array, options={})
    model_name = record_or_array.is_a?(Array) ? record_or_array.last : record_or_array
    options[:url] = polymorphic_path([:new].push(record_or_array).flatten , options[:url_options] || {})
    options[:model_name] = model_name
    base_new_btn(options)
  end

  def info_btn(record_or_array, options={})
    options[:url] = polymorphic_path([].push(record_or_array).flatten , options[:url_options] || {})
    base_info_btn(options)
  end

  def edit_btn(record_or_array, options={})
    options[:url] = polymorphic_path([:edit].push(record_or_array).flatten , options[:url_options] || {})
    base_edit_btn(options)
  end

  def delete_btn(record_or_array, options={})
    options[:url] = polymorphic_path([].push(record_or_array).flatten , options[:url_options] || {})
    base_delete_btn(options)
  end

  def base_new_btn(options={})
    options[:title] ||= '新建'
    options[:btn_size] ||= 'btn-xs'
    options[:remote] ||= false
    options[:model_name] ||= ""
    btn_class = options[:no_btn_class] ? '' : "btn #{options[:btn_size]} btn-primary"
    link_to tag(:icon, :class => "fa fa-plus #{options[:icon_class]}") + " #{options[:label]}", options[:url], id: "new_#{options[:model_name]}_btn", :class => [btn_class, options[:class]], :remote => options[:remote], :title => options[:title]
  end

  def base_info_btn(options={})
    options[:title] ||= '详情'
    options[:btn_size] ||= 'btn-xs'
    options[:show_label] ||= false
    options[:remote] ||= false
    btn_class = options[:no_btn_class] ? '' : "btn #{options[:btn_size]} btn-info"
    options[:method] ||= :get
    link_to options[:title], options[:url], :class => [options[:class]], :remote => options[:remote], :method => options[:method], :title => options[:title]
  end

  def base_edit_btn(options={})
    options[:title] ||= '编辑'
    options[:btn_size] ||= 'btn-xs'
    options[:remote] ||= false
    btn_class = options[:no_btn_class] ? '' : "btn #{options[:btn_size]} btn-success"
    link_to options[:title], options[:url], :class => [options[:class]], :remote => options[:remote], :title => options[:title]
  end

  def base_delete_btn(options={})
    options[:title] ||= '删除'
    options[:btn_size] ||= 'btn-xs'
    options[:remote] ||= false
    btn_class = options[:no_btn_class] ? '' : "btn #{options[:btn_size]} btn-danger"
    link_to options[:title], options[:url], :class => [options[:class]], :'data-confirm' => "确定删除?", :method => :delete, :remote => options[:remote], :title => options[:title]
  end
end