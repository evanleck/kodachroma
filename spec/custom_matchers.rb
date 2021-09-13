# frozen_string_literal: true
RSpec::Matchers.define :generate_palette do |expected|
  expected.map! { |e| Kodachroma.paint(e) }

  match do |actual|
    actual == expected
  end
end

RSpec::Matchers.define :have_format do |expected|
  match do |actual|
    actual.format == expected
  end
end

RSpec::Matchers.define :be_dark do
  match(&:dark?)
end

RSpec::Matchers.define :be_light do
  match(&:light?)
end
