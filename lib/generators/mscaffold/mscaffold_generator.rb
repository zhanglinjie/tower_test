require 'rails/generators/erb/scaffold/scaffold_generator'
class MscaffoldGenerator < Erb::Generators::ScaffoldGenerator
  source_root File.expand_path('../templates', __FILE__)

  def copy_view_files
    available_views.each do |view|
      template view, File.join('app', 'views', controller_file_path, view)
    end
    template "controller.rb", File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
    template "controller_spec.rb", File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb")
  end

  hook_for :form_builder, as: :scaffold

  protected
  def available_views
    %W(_form _info _table _table_tr edit index new show).map{|name| "#{name}.html.slim"} +
    %W(create edit new show update destroy).map{|name| "#{name}.js.erb"}
  end

  def handler
    :slim
  end

  def attributes_hash
    return if attributes_names.empty?

    attributes_names.map do |name|
      if %w(password password_confirmation).include?(name) && attributes.any?(&:password_digest?)
        "#{name}: 'secret'"
      else
        "#{name}: @#{singular_table_name}.#{name}"
      end
    end.sort.join(', ')
  end
end
