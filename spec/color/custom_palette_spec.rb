# frozen_string_literal: true
describe Kodachroma::Color, '#custom_palette' do
  let(:subject) do
    Kodachroma.paint('red').custom_palette do
      spin 60
      spin 180
      spin(60).brighten(20)
      greyscale
    end
  end

  it 'generates the correct colors' do
    expect(subject)
      .to generate_palette %w[#ff0000 #ffff00 #00ffff #ffff33 #808080]
  end

  it 'keeps the same format' do
    expect(subject).to all have_format :name
  end
end
