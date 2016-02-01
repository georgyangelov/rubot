module Rubot
  class Memory
    attr_reader :data

    def initialize(file_path)
      @file_path = file_path
      @data = load
    end

    def for_channel(channel)
      self[:channels] ||= {}
      self[:channels][channel.to_s] ||= {}

      self[:channels][channel.to_s]
    end

    def [](*args)
      @data[*args]
    end

    def []=(*args)
      @data.[]=(*args)
    end

    def save
      File.write(@file_path, YAML.dump(@data))
    end

    private

    def load
      YAML.load_file(@file_path) || {}
    rescue Errno::ENOENT
      {}
    end
  end
end
