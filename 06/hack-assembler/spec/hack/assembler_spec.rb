RSpec.describe Hack::Assembler do
  it 'Test Add.asm' do
    hack_result = File.read('spec/hack/fixtures/Add.hack')
    res = Hack::Assembler::Main.call('spec/hack/fixtures/Add.asm')
    expect(res).to eq(hack_result)
  end

  it 'Test Max.asm' do
    hack_result = File.read('spec/hack/fixtures/Max.hack')
    res = Hack::Assembler::Main.call('spec/hack/fixtures/Max.asm')
    expect(res).to eq(hack_result)
  end

  it 'Test Rect.asm' do
    hack_result = File.read('spec/hack/fixtures/Rect.hack')
    res = Hack::Assembler::Main.call('spec/hack/fixtures/Rect.asm')
    expect(res).to eq(hack_result)
  end
end
