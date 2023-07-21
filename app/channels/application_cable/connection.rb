module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      reject_unauthorized_connection unless current_user
    end

    private

    def find_verified_user
      if (verified_user = env['warden'].user(:user)) # first look for :user scope
        verified_user
      elsif (verified_admin = env['warden'].user(:admin_user)) # then fallback to :admin_user scope
        verified_admin
      else
        reject_unauthorized_connection
      end
    end
  end
end

