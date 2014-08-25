Warden::Manager.serialize_into_session do |user|
  user.serializable_hash
end

Warden::Manager.serialize_from_session do |hash|
  User.new(hash)
end

Rails.configuration.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |_manager|

end
