 class DatePickerInput < Formtastic::Inputs::StringInput
include Formtastic::Inputs::Base

    def input_html_options
        super.merge(:class => "datepicker")
    end 
 end