module Coollala
  class SessionStore
    @@sessions ||= {}
    private_class_method :new
    def initialize(key, value, expire)
      return nil if @@sessions.has_key?(key)
      @@sessions[key] = Marshal.dump({:data => value, :expire => expire})
    end
    def self.create(params={})
      params[:expire] ||= 360000
      key = params.delete(:username)
      data = params.delete(:userdata)
      expire = params.delete(:expire)
      unless @@sessions.has_key?(key)
        new(key, data, expire)
      end
      Marshal.load(@@sessions[key])
    end
    def self.get(key)
      if @@sessions.has_key?(key)
        Marshal.load(@@sessions[key])
      else
        nil
      end
    end
    def self.stored_data
      @@sessions
    end
  end
end