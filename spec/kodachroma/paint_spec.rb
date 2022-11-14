# frozen_string_literal: true
require 'spec_helper'

describe Kodachroma do
  describe '.paint' do
    context 'with named color' do
      it 'creates a color' do
        expect(described_class.paint('red')).to be_a(Kodachroma::Color)
      end
    end

    context 'with 6 character hexadecimal' do
      it 'creates a color' do
        expect(described_class.paint('#ff0000')).to be_a(Kodachroma::Color)
        expect(described_class.paint('ff0000')).to be_a(Kodachroma::Color)
      end
    end

    context 'with 3 character hexadecimal' do
      it 'creates a color' do
        expect(described_class.paint('#f00')).to be_a(Kodachroma::Color)
        expect(described_class.paint('f00')).to be_a(Kodachroma::Color)
      end
    end

    context 'with 8 character hexadecimal' do
      let(:hex) { '#80ff0000' }

      it 'creates a color' do
        expect(described_class.paint(hex)).to be_a(Kodachroma::Color)
        expect(described_class.paint(hex[1..-1])).to be_a(Kodachroma::Color)
      end

      it 'sets alpha' do
        expect(described_class.paint(hex).alpha).to eq(0)
      end
    end

    context 'with rgb' do
      it 'creates a color' do
        expect(described_class.paint('rgb(255, 0, 0)')).to be_a(Kodachroma::Color)
        expect(described_class.paint('rgba(255, 0, 0, 0.5)')).to be_a(Kodachroma::Color)
      end

      it 'sets alpha' do
        expect(described_class.paint('rgba(255, 0, 0, 0.5)').alpha).to eq(0.5)
      end
    end

    context 'with hsl' do
      it 'creates a color' do
        expect(described_class.paint('hsl(120, 100%, 50%)')).to be_a(Kodachroma::Color)
      end

      it 'parses the rgb properly' do
        result = described_class.paint('hsl(120, 100%, 50%)')
        expect(result.rgb.r).to eql(0)
        expect(result.rgb.g).to eql(255.0)
        expect(result.rgb.b).to eql(0)

        result = described_class.paint('hsl(60 1% 34%)')
        expect(result.rgb.r.round).to eql(88)
        expect(result.rgb.g.round).to eql(88)
        expect(result.rgb.b.round).to eql(86)
      end
    end
  end
end
