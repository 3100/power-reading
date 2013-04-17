BUNDLES = %w(js/application.js css/application.css)

task :compile do
  require 'sprockets'
  environment = Sprockets::Environment.new(File.dirname(__FILE__))
  environment.append_path 'src/coffee'
  environment.append_path 'src/sass'

  BUNDLES.each do |bundle|
    assets = environment.find_asset File.basename(bundle)
    assets.write_to("public/" + bundle + ".tmp")
  end
end

task :default => :compile





