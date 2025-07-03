Obscenity.configure do |config|
  config.blacklist   = YAML.load_file(Rails.root.join("config", "blacklist.yml"))["blacklist"]
  config.replacement = :stars
end
