# Not used right now.
class Array
  def compact_with_schrodinger
    compact_without_schrodinger.reject(&:nil?)
  end
  alias_method_chain :compact, :schrodinger
end
