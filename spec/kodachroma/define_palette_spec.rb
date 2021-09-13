# frozen_string_literal: true
describe Kodachroma, '.define_palette' do
  def add_palette
    Kodachroma.define_palette :foo do
      spin 60
      spin 180
      spin(60).brighten(20)
      greyscale
    end
  end

  def remove_palette
    if Kodachroma::Harmonies.method_defined? :foo
      Kodachroma::Harmonies.send(:remove_method, :foo)
    end
  end

  after { remove_palette }

  let(:red) { described_class.paint '#ff0000' }

  it 'adds the new palette method' do
    expect(red.palette).not_to respond_to(:foo)
    add_palette
    expect(red.palette).to respond_to(:foo)
  end

  it 'generates the correct colors' do
    add_palette

    expect(red.palette.foo)
      .to generate_palette %w[#ff0000 #ffff00 #00ffff #ffff33 #808080]
  end

  it 'keeps the same format' do
    add_palette

    expect(described_class.paint('red').palette.foo).to all have_format :name
  end
end
