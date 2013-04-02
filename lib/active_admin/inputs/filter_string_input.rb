module ActiveAdmin
  module Inputs
    class FilterStringInput < ::Formtastic::Inputs::StringInput
      include FilterBase
      include FilterBase::SearchMethodSelect

      # If the filter method includes a search condition, build a normal string search field.
      # Else, build a search field with a companion dropdown to choose a search condition from.
      def to_html
        if search_conditions =~ method.to_s
          input_wrapping do
            label_html <<
            builder.text_field(method, input_html_options)
          end
        else
          super # SearchMethodSelect#to_html
        end
      end

      def search_conditions
        /_(contains|starts_with|ends_with)\z/
      end

      def input_name
        method.to_s.match(search_conditions) ? method : "#{method}_cont"
      end

      def search_conditions
        /start|not_start|end|not_end/
      end
    end
  end
end
