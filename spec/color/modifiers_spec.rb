# frozen_string_literal: true
describe Kodachroma::Color do
  let(:red)    { Kodachroma.paint 'red' }
  let(:yellow) { Kodachroma.paint 'yellow' }

  describe '#lighten' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect(red.lighten).to eq Kodachroma.paint('#ff3333')
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect(red.lighten(20)).to eq Kodachroma.paint('#ff6666')
      end
    end
  end

  describe '#brighten' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect(red.brighten).to eq Kodachroma.paint('#ff1a1a')
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect(red.brighten(20)).to eq Kodachroma.paint('#ff3333')
      end
    end
  end

  describe '#darken' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect(red.darken).to eq Kodachroma.paint('#cc0000')
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect(red.darken(20)).to eq Kodachroma.paint('#990000')
      end
    end
  end

  describe '#desaturate' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect(red.desaturate).to eq Kodachroma.paint('#f20d0d')
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect(red.desaturate(20)).to eq Kodachroma.paint('#e61919')
      end
    end
  end

  describe '#saturate' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect(Kodachroma.paint('#123').saturate).to eq Kodachroma.paint('#0e2236')
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect(Kodachroma.paint('#123').saturate(20)).to eq Kodachroma.paint('#0a223a')
      end
    end
  end

  describe '#grayscale' do
    it 'generates the correct color' do
      expect(red.grayscale).to eq Kodachroma.paint('gray')
      expect(Kodachroma.paint('green').grayscale).to eq Kodachroma.paint('#404040')
    end
  end

  describe '#opacity' do
    it 'sets color opacity to supplied amount' do
      green_a = Kodachroma.paint('rgba(0, 128, 0, 0.5)')
      expect(green_a.opacity(1)).to eq Kodachroma.paint('rgba(0, 128, 0, 1)')
      expect(Kodachroma.paint('green').opacity(0)).to eq Kodachroma.paint('rgba(0, 128, 0, 0)')
      expect(red.opacity(0.3)).to eq Kodachroma.paint('rgba(100%, 0%, 0%, 0.3)')
    end
  end

  describe '#spin' do
    it 'generates the correct color' do
      expect(red.spin(60)).to eq yellow
    end
  end
end
