Warden::Manager.serialize_into_session(&:serializable_hash)

Warden::Manager.serialize_from_session do |hash|
  User.new(hash)
end

Rails.configuration.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |_manager|
end
