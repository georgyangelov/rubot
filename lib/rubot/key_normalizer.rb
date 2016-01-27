module Rubot
  module KeyNormalizer
    SUFFIXES = [
      # I know this is not even remotely correct in all cases...
      'и',
      'ите',
      'ове',
      'овете',
      'ата',
      'те',
      'а',
    ].deep_freeze

    def self.normalize(key)
      key = key.strip.mb_chars.downcase.to_s
      normalized_key = key.sub(/(#{SUFFIXES.join('|')})\z/i, '')

      return key if normalized_key.empty?

      normalized_key
    end
  end
end
