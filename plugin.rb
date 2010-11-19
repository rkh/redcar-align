Plugin.define do
  name "align"
  version "0.1"
  file "lib", "redcar-align"
  object "Redcar::Align"
  dependencies "core", ">0", "application", ">0", "edit_view", ">0"
end
