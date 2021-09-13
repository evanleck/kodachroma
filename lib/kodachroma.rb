# frozen_string_literal: true
# General
require 'kodachroma/version'
require 'kodachroma/errors'
require 'yaml'

# Modules
require 'kodachroma/helpers/bounders'

# Color
require 'kodachroma/color/attributes'
require 'kodachroma/color/serializers'
require 'kodachroma/color/modifiers'
require 'kodachroma/color'
require 'kodachroma/color_modes'

# Palettes
require 'kodachroma/harmonies'
require 'kodachroma/palette_builder'

# RGB Generators
require 'kodachroma/rgb_generator'
require 'kodachroma/rgb_generator/base'
require 'kodachroma/rgb_generator/from_string'
require 'kodachroma/rgb_generator/from_rgb_values'
require 'kodachroma/rgb_generator/from_rgb'
require 'kodachroma/rgb_generator/from_hsl_values'
require 'kodachroma/rgb_generator/from_hsl'
require 'kodachroma/rgb_generator/from_hsv_values'
require 'kodachroma/rgb_generator/from_hsv'
require 'kodachroma/rgb_generator/from_hex_string_values'

# Converters
require 'kodachroma/converters/base'
require 'kodachroma/converters/rgb_converter'
require 'kodachroma/converters/hsl_converter'
require 'kodachroma/converters/hsv_converter'

# The main module.
module Kodachroma
  class << self
    # Returns a new instance of color. Supports hexadecimal, rgb, rgba, hsl,
    # hsla, hsv, hsva, and named color formats.
    #
    # @api public
    #
    # @example
    #   Kodachroma.paint('red')
    #   Kodachroma.paint('#f00')
    #   Kodachroma.paint('#ff0000')
    #   Kodachroma.paint('rgb(255, 0, 0)')
    #   Kodachroma.paint('hsl(0, 100%, 50%)')
    #   Kodachroma.paint('hsv(0, 100%, 100%)')
    #
    # @param input [String] the color
    # @return      [Color]  an instance of {Color}
    def paint(input)
      Color.new(input)
    end

    # Returns the hexadecimal string representation of a named color and nil
    # if no match is found. Favors 3-character hexadecimal if possible.
    #
    # @example
    #   Kodachroma.hex_from_name('red')       #=> 'f00'
    #   Kodachroma.hex_from_name('aliceblue') #=> 'f0f8ff'
    #   Kodachroma.hex_from_name('foo')       #=> nil
    #
    # @param name [String]      the color name
    # @return     [String, nil] the color as a string hexadecimal or nil
    def hex_from_name(name)
      named_colors_map[name]
    end

    # Returns the color name of a hexadecimal color if available and nil if no
    # match is found. Requires 3-character hexadecimal input for applicable
    # colors.
    #
    # @example
    #   Kodachroma.name_from_hex('f00')    #=> 'red'
    #   Kodachroma.name_from_hex('f0f8ff') #=> 'aliceblue'
    #   Kodachroma.name_from_hex('123123') #=> nil
    #
    # @param hex [String]      the hexadecimal color
    # @return    [String, nil] the color name or nil
    def name_from_hex(hex)
      hex_named_colors_map[hex]
    end

    # Defines a custom palette for use by {Color#palette}. Uses a DSL inside
    # `block` that mirrors the methods in {Color::Modifiers}.
    #
    # @example
    #   'red'.paint.palette.respond_to? :my_palette #=> false
    #
    #   Kodachroma.define_palette :my_palette do
    #     spin 60
    #     spin 120
    #     spin 240
    #   end
    #
    #   'red'.paint.palette.respond_to? :my_palette #=> true
    #
    # @param name  [Symbol, String]              the name of the custom palette
    # @param block [Proc]                        the palette definition block
    # @raise       [Errors::PaletteDefinedError] if the palette is already defined
    # @return      [Symbol, String]              the name of the custom palette
    def define_palette(name, &block)
      if Harmonies.method_defined? name
        raise Errors::PaletteDefinedError, "Palette `#{ name }' already exists"
      end

      palette_evaluator = PaletteBuilder.build(&block)

      Harmonies.send(:define_method, name) do
        palette_evaluator.evaluate(@color)
      end
    end

    private

    def hex_named_colors_map
      @hex_named_colors_map ||= named_colors_map.invert
    end

    def named_colors_map
      @named_colors ||= YAML.load_file(File.expand_path('support/named_colors.yml', __dir__))
    end
  end
end
