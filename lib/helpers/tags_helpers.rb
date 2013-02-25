module Sinatra
	module Coollala
		module TagsHelpers
			def hidden_field_tag(name)
				"<input type='hidden' name='_method' value='#{name.to_s}' />"
			end
		end
	end
	helpers Coollala::TagsHelpers
end