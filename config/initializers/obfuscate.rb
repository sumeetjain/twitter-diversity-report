require 'obfuscate/obfuscatable'
Obfuscate.setup do |config|
  config.salt = "$Sally*%FISH--#yolo9421" # Length must be between 1-56 
end