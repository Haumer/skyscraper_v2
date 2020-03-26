json.array! @searches do |search|
  json.extract! search, :id, :keyword, :location
end
