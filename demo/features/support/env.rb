require 'kuroko'

Kuroko.configure do |config|
  config.vagrant_root = File.expand_path('../../../', __FILE__)
end
