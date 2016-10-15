class Object
  alias_method :deep_freeze, :freeze
end

class Array
  def deep_freeze
    each(&:deep_freeze)

    freeze
  end
end

class Hash
  def deep_freeze
    each do |key, value|
      key.deep_freeze
      value.deep_freeze
    end

    freeze
  end
end
