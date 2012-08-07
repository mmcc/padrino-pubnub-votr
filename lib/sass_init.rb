module SassInitializer
  def self.registered(app)
    require 'sass/plugin/rack'
    apps = {}
    apps[app] = app.to_s.downcase
    template_locations = { Padrino.root("app/stylesheets") => Padrino.root("public/stylesheets") }
    apps.each do |name, path|
      template_locations[Padrino.root("#{path}/stylesheets")] = Padrino.root("public/#{path}/stylesheets")
    end
    Sass::Plugin.options[:template_location] = template_locations
    app.use Sass::Plugin::Rack
  end
end