require File.expand_path('../schrodingers_cat/dependencies', __FILE__)
require File.expand_path('../schrodingers_cat/core_ext',     __FILE__)

class SchrodingersCat
  #######################
  ## Schrodinger's Cat ##
  #######################
  #
  # Able to avoid shit like: user_or_id.is_a?(User) ? user_or_id.id : user_or_id
  # in favor of user_or_id.if_a?(User).id
  # or          user_or_id.if_a?(User, :else => user_or_id).id
  # or          user_or_id.only_if_a?(User) || user_or_id

  #####################
  ## Note:           ##
  #####################
  # These can't be overriden as they are not methods but low-level operators... ):
  #   define_method(:"&&") {|obj| false }; define_method(:"||") {|obj| obj }
  # which means I can't reliably do something like record.assuming_a(User).authentications.first || raise "You didn't supply a user with authentications!"
  # because if sc.is_a?(SchrodingersCat), we ideally want:
  # sc || false     # => false
  # true && sc      # => false
  # but instead, as || and && are low-level operators for short-circuiting, we get:
  # sc || false     # => sc
  # true && sc      # => sc
  # However, though normally nil is the only object which should respond to #nil? with a true, so does SchrodingersCat whose MODEL_OBJECT is nil.
  attr_accessor :original, :method_chain, :else
  unless const_defined?(:MODEL_OBJECT)
    SchrodingersCat.const_set(:MODEL_OBJECT, nil)
  end

  def initialize(original, attrs={})
    self.original, self.method_chain  = original, Array.wrap(attrs[:method_chain])
    self.else, @_else_set             = attrs[:else], true if attrs.key?(:else)
  end

  [ 'inspect', 'to_s', 'to_i', 'nil?', 'empty?' ,'blank?' ].each do |meth|
    class_eval %{ def #{meth}; MODEL_OBJECT.#{meth}; end; }
  end
  #delegate *[ 'inspect', 'to_s', 'to_i', 'nil?', 'empty?' ,'blank?' ].map(&:intern), :to => :MODEL_OBJECT
  
  if Rails.env.development?
    def inspect; "nil (SchrodingersCat)"; end
  end

  [ "==", "eql?", "&", "^", "|" ].each do |meth|
    class_eval %{ def #{meth}(other); MODEL_OBJECT.#{meth}(other); end; }
  end
  #delegate *[ "==", "eql?", "&", "^", "|" ].map(&:intern), :to => :MODEL_OBJECT
  
  def dup; nil; end

  def method_missing(method_sym, *arguments, &block)
    return self.else if @_else_set
    self.method_chain << { method_sym => arguments.push(&block) }
    self
  end
  private :method_missing
end
