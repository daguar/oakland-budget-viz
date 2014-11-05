$stdout.sync = true

use Rack::Static,
  :urls => ["/css", "/js", "/images", "/spec", "/4stage.html"],
  :root => "."

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('4stage.html', File::RDONLY)
  ]
}

