module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize

    order = column == sort_column && sort_order == "asc" ? "desc" : "asc"

    link_to title, params.merge(:sort => column, :order => order, :page => nil)
  end

  def is_current_controller?(controller_name)
    "current" if params[:controller] == controller_name
  end

  def is_current_action?(action_name)
    "current" if params[:action] == action_name
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new

    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end

    link_to name, "#javascript", :onclick => "arguments[0].preventDefault(); addFields(this, \'#{association}\', \'#{escape_javascript(fields.html_safe)}\');"

    #link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")".html_safe)
  end
end