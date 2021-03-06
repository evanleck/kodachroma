# frozen_string_literal: true
describe Kodachroma::Color do
  let(:red)    { Kodachroma.paint 'red' }
  let(:black)  { Kodachroma.paint 'black' }
  let(:white)  { Kodachroma.paint 'white' }
  let(:yellow) { Kodachroma.paint 'yellow' }

  describe '#dark?' do
    it 'returns true for dark colors' do
      expect(red).to   be_dark
      expect(black).to be_dark
    end

    it 'returns false for light colors' do
      expect(white).not_to  be_dark
      expect(yellow).not_to be_dark
    end
  end

  describe '#light?' do
    it 'returns false for dark colors' do
      expect(red).not_to   be_light
      expect(black).not_to be_light
    end

    it 'returns true for light colors' do
      expect(white).to  be_light
      expect(yellow).to be_light
    end
  end

  describe '#alpha' do
    it 'returns the correct alpha value' do
      expect(Kodachroma.paint('rgba(255, 0, 0, 0.75)').alpha).to eq 0.75
      expect(Kodachroma.paint('#80ff0000').alpha).to             eq 0
      expect(Kodachroma.paint('transparent').alpha).to           eq 0
      expect(Kodachroma.paint('hsla(0, 100%, 50%, 0)').alpha).to eq 0
      expect(red.alpha).to eq 1
    end
  end

  describe '#brightness' do
    it 'returns the correct brightness' do
      expect(red.brightness).to    eq 76.245
      expect(black.brightness).to  eq 0
      expect(white.brightness).to  eq 255
      expect(yellow.brightness).to eq 225.93
    end
  end
end
