require "hyper/app/railtie"


# Rails.application.reload_routes!
# all_routes = Rails.application.routes.routes

# require 'rails/application/route_inspector'
# inspector = Rails::Application::RouteInspector.new
# for routeRule in inspector.format(all_routes, ENV['CONTROLLER'])
#    puts routeRules
# end

module Hyper

    class Controller 
      
    end

    module Router
      def hyper_resources(*resources)
        resources(*resources)
        resources.each do | resource |
          name = "#{resource}Controller"
          name = name.slice(0,1).capitalize + name.slice(1..-1)
          myClass = Class.new(ApplicationController)
          
          myClass.class_eval do 

            def index
              hyperClass = Object.const_get("Hyper#{self.controller_name}")
              hyperInstance = hyperClass.new
              render json: hyperInstance.index
            end

            def self.controller_name=(value)
              @controller_name = value
            end

            def self.controller_name
              @controller_name
            end

          end
          myClass.controller_name = name
          Object.const_set(name, myClass)     
        end
      end
    end
end
ActionDispatch::Routing::Mapper.send :include, Hyper::Router