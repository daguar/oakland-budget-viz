$stdout.sync = true

use Rack::Static,
  :urls => ["/css", "/js", "/images", "/spec", "/"],
  :root => "."

run Rack::Directory.new("/")
