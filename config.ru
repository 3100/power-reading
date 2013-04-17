#require "rubygems"
#require "bundler"
#Bundler.require(:default)

map "/" do
  use Rack::Static, :urls => ["/css", "/js", "/se", "/lib", "/data"], :root => Dir.pwd + "/public"

  run lambda {|env|
    headers = {
      "Content-Type" => "text/html",
      "Cache-Control" => "public, max-age=86400"
    }
    body = File.open("#{Dir.pwd}/public/index.html", File::RDONLY).read

    [200, headers, [body]]
  }
end
