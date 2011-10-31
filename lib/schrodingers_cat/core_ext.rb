class Object
  # if user_or_id.is_a?(User) then do #id, else just return user_or_id
  # Ex: user_or_id = User.first
  #     user_or_id.if_a?(User).id
  # =>  1
  #     user_or_id = User.first.id
  #     user_or_id.if_a?(User).id
  # =>  1
  def if_a?(*others, &block)
    others.flatten_splat! # decide whether im using these or not. already using merge_options and shit.
    opts = others.extract_options!
    check_conditions = opts.key?(:conditions) ? opts.delete(:conditions) : send((opts.delete(:check) || :is_one_kind_of?), *others)
    if opts.delete(:opposite) ? !check_conditions : check_conditions
      block_given? ? yield(self) : self
    else # :else => self is the default, for when i dont do any operations on original object.
      opts.merge!(:else => self)  unless opts.key?(:else) || opts[:chain] # if opts[:chain] is passed, then there is never an :else.
      return opts[:else]          if block_given? && opts.key?(:else)
      SchrodingersCat.new(self, opts)
    end
  end

  def unless_a?(*others, &block)
    if_a?(*others.merge_options!(:opposite => true), &block)
  end

  # Only if user_or_id.is_a?(User) run chained method normally. Otherwise, return nil on chained method call.
  # Ex: possible_match = "hello".match(/ello/)
  #     possible_match.only_if_a?(MatchData)[0]
  # =>  "ello"
  #     possible_match = "hello".match(/superman/)
  #     possible_match.only_if_a?(MatchData)[0]
  # =>  nil
  def only_if_a?(*others, &block)
    if_a?(*others.merge_options(:else => nil), &block)
  end

  def only_unless_a?(*others, &block)
    only_if_a?(*others.merge_options(:opposite => true), &block)
  end

  # if user_or_id.is_a?(User) continue with chain, else continue returning Schrodinger's Cat.
  # Ex: user_or_id = User.first
  #     res = user_or_id.assuming_a(User).authentications.first.provider # assuming an authentications record exists.
  # =>  "facebook"
  #     res.class
  # =>  String
  #     user_or_id = User.find_by_email('noone@kibblr.com') # if there is no user with ID=999,
  #     res = user_or_id.assuming_a(User).authentications.first.provider
  # =>  nil
  #     res.class
  # =>  SchrodingersCat
  def assuming_a(*others, &block)
    if_a?(*others.merge_options(:chain => true), &block)
  end

  ##################################
  # Exact comparison of #== in is_one_of? rather than utilizing #=== in #is_one_kind_of
  ###############################
  def if_equals_a?(*others, &block);                     if_a?(*others.merge_options(:check     => :is_included_in?), &block); end
  def unless_equals_a?(*others, &block);          if_equals_a?(*others.merge_options(:opposite  => true),             &block); end
  def only_if_equals_a?(*others, &block);         if_equals_a?(*others.merge_options(:else      => nil),              &block); end
  def only_unless_equals_a?(*others, &block); unless_equals_a?(*others.merge_options(:else      => nil),              &block); end
  def assuming_equals_a(*others, &block);         if_equals_a?(*others.merge_options(:chain     => true),             &block); end

  #########################
  # Custom conditionals. ##
  #########################
  def if?(varied, *args, &block)      if_a?(*args.merge_options(:conditions => resolve_conditions(varied)), &block); end
  def unless?(*args, &block);           if?(*args.merge_options(:opposite   => true),                       &block); end
  def only_if?(*args, &block);          if?(*args.merge_options(:else       => nil),                        &block); end
  def only_unless?(*args, &block); only_if?(*args.merge_options(:opposite   => true),                       &block); end
  #def assuming(*args, &block);          if?(*args.merge_options(:chain      => true),                       &block); end

  #########################
  # Utilities            ##
  #########################
  def present_else_nil;     present_else(nil);     end
  def significant_else_nil; significant_else(nil); end

  protected
  def present_else(other);     if?(:present?,     :else => other) { self }; end
  def significant_else(other); if?(:significant?, :else => other) { self }; end

  private
  def resolve_conditions(varied)
    varied.is_a?(Symbol) ? __send__(varied) : varied.is_a?(Array) ? __send__(*varied) : varied.is_a?(String) ? varied[0] =~ /\./ ? __send__(:eval, "self#{varied}") : eval(varied) : !!varied
  end
end
