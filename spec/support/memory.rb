module MemoryStubs
  def stub_file_writes
    allow_any_instance_of(Rubot::Memory).to receive(:load).and_return({})
    allow_any_instance_of(Rubot::Memory).to receive(:save)
  end

  def clean_memory
    Rubot.memory.instance_variable_set(:@data, {})
  end
end

RSpec.configure do |c|
  c.include MemoryStubs

  c.before(:each) do
    stub_file_writes
    clean_memory
  end
end
