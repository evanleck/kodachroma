# frozen_string_literal: true
describe Kodachroma do
  describe '.hex_from_name' do
    it 'returns the hex representation for a color name' do
      described_class::NAMED_COLORS.each do |name, hex|
        expect(described_class.hex_from_name(name)).to eq hex
      end
    end

    it 'returns nil for unknown colors names' do
      expect(described_class.hex_from_name('foo')).to be_nil
    end
  end

  describe '.name_from_hex' do
    it 'returns a color name for a hex representation' do
      described_class::NAMED_COLORS.each do |_name, hex|
        expect(described_class.name_from_hex(hex)).to be
      end
    end

    it 'returns nil for hex values without a corresponding color name' do
      expect(described_class.name_from_hex('#123123')).to be_nil
    end
  end
end
