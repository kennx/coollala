module ApplicationController;end;
module UsersController;end;

module Sinatra
	module Coollala
		module Controllers
			def self.registered(base)
				base.send :include, ApplicationController
				base.send :include, UsersController
			end
		end
	end
	register Coollala::Controllers

end