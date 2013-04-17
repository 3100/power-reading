use Rack::Static,
  :urls => ["/css", "/js", "/se", "/lib", "/data"],
  :root => "public"

run lambda {|env|
  headers = {
    "Content-Type" => "text/html",
    "Cache-Control" => "public, max-age=86400"
  }
  body = File.open("/public/index.html", File::RDONLY).read
  [200, headers, [body]]
}
