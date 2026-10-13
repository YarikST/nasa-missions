# frozen_string_literal: true

{
  "Earth" => "9.807",
  "Moon" => "1.62",
  "Mars" => "3.711"
}.each do |name, gravity|
  Planet.find_or_create_by!(name: name) { |planet| planet.gravity = gravity }
end
