module Interface

  def self.included(klass)
    klass.extend ClassMethods
  end
  
  def self.registered
    @registered ||= {}
  end
  
  def self.[](interface)
    registered[interface.to_sym] || 
      raise("#{interface} not in interfaces: #{@registered.keys.inspect}")
  end
  
  def self.register(interface, name)
    registered[name] = interface
  end
  
  

  module ClassMethods
    def implements(*interfaces)
      (@interface_manager ||= Manager.new(self)) << interfaces
    end
    
    def implements?(interface)
      implements.implements?(interface)
    end
    
    def implements!
      implements.check!
    end
  end

  module InstanceMethods
  end

  class Base
    include Interface
  end

  # =====
  class Manager
    def initialize(klass)
      @klass, @interfaces = klass, []
    end

    def <<(interfaces)
      (@interfaces << interfaces).flatten!
      self
    end
    
    def implements?(interface)
      return false unless @interfaces.include?(interface) 
      ::Interface[interface].implemented_on?(@klass) || nil
    end
    
    def check!
      @interfaces.all? do |interface|
        implements?(interface) || raise("#{@klass} does not implement interface: #{interface}")
      end
    end
  end
  
  Interface = Struct.new(:name, :methods) do
    def to_sym
      name.to_sym
    end
    
    def implemented_on?(klass)
      @methods.all? {|method| klass.instance_methods.include? method.to_s }
    end
    
    def method(name)
      (@methods ||= []) << name
    end
  end
    
end


def Interface(name, &block)
  interface = Interface::Interface.new(name, [])
  interface.instance_eval(&block)
  Interface.register(interface, name)
end
