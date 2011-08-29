class Array
  def options_extractable?
    last.is_a?(Hash) && last.extractable_options?
  end
  
  def flatten_splat(with_bang=false)
    flatten_splat_needed? ? with_bang ? flatten! : flatten : self
  end

  def flatten_splat!
    flatten_splat(true)
  end
  
  def flatten_splat_needed?
    self.size == 1 and first.is_a?(Array)
  end
  private :flatten_splat_needed?
  
  def merge_options(update_hash={})
    endex, base_hash = options_extractable? ? [ -2, last ] : [ -1, {} ]
    Array[ *self[0..endex], base_hash.merge(update_hash || {}) ]
  end; alias_method :merge_opts, :merge_options

  def merge_options!(update_hash={})
    push(extract_options!(update_hash))
  end; alias_method :merge_opts!, :merge_options!
  
end