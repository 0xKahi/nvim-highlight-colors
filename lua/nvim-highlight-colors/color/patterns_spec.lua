local patterns = require('nvim-highlight-colors.color.patterns')
local utils = require('nvim-highlight-colors.color.utils')
local assert = require('luassert')

describe('Patterns', function()
  it('should return true if color is short hex', function()
    assert.is_true(patterns.is_short_hex_color('#FFF'))
  end)

  it('should return false if color is not short hex', function()
    assert.is_false(patterns.is_short_hex_color('#FFFFFF'))
    assert.is_false(patterns.is_short_hex_color('rgb(255, 255, 255)'))
    assert.is_false(patterns.is_short_hex_color('hsl(240, 100%, 50%)'))
  end)

  it('should return true if color is hex', function()
    assert.is_true(patterns.is_hex_color('#FFFFFF'))
  end)

  it('should return false if color is not hex', function()
    assert.is_false(patterns.is_hex_color('#FFF'))
    assert.is_false(patterns.is_hex_color('rgb(255, 255, 255)'))
    assert.is_false(patterns.is_hex_color('hsl(240, 100%, 50%)'))
  end)

  it('should return true if color is hex with alpha layer', function()
    assert.is_true(patterns.is_alpha_layer_hex('#FFFFFFFF'))
  end)

  it('should return false if color is not hex with alpha layer', function()
    assert.is_false(patterns.is_alpha_layer_hex('#FFF'))
    assert.is_false(patterns.is_alpha_layer_hex('#FFFFFF'))
    assert.is_false(patterns.is_alpha_layer_hex('rgb(255, 255, 255)'))
    assert.is_false(patterns.is_alpha_layer_hex('hsl(240, 100%, 50%)'))
  end)

  it('should return true if color is rgb', function()
    assert.is_true(patterns.is_rgb_color('rgb(255, 255, 255)'))
    assert.is_true(patterns.is_rgb_color('rgb(255 255 255)'))
    assert.is_true(patterns.is_rgb_color('rgba(92, 92, 255 / 0.2)'))
    assert.is_true(patterns.is_rgb_color('rgba(0, 255, 0 / 20%)'))
    assert.is_true(patterns.is_rgb_color('rgba(255 0 0 0)'))
  end)

  it('should return false if color is not rgb', function()
    assert.is_false(patterns.is_rgb_color('#FFF'))
    assert.is_false(patterns.is_rgb_color('#FFFFFF'))
    assert.is_false(patterns.is_rgb_color('#FFFFFFFF'))
    assert.is_false(patterns.is_rgb_color('hsl(240, 100%, 50%)'))
    assert.is_false(patterns.is_rgb_color('\033[0;30m'))
  end)

  it('should return true if color is hsl', function()
    assert.is_true(patterns.is_hsl_color('hsl(240, 100%, 68%)'))
    assert.is_true(patterns.is_hsl_color('hsl(150deg 30% 40%)'))
    assert.is_true(patterns.is_hsl_color('hsl(0.3turn 60% 15%) '))
    assert.is_true(patterns.is_hsl_color('hsl(240 100% 68%)'))
  end)

  it('should return false if color is not hsl', function()
    assert.is_false(patterns.is_hsl_color('#FFF'))
    assert.is_false(patterns.is_hsl_color('#FFFFFF'))
    assert.is_false(patterns.is_hsl_color('#FFFFFFFF'))
    assert.is_false(patterns.is_hsl_color('rgb(255, 255, 255)'))
    assert.is_false(patterns.is_hsl_color('\033[0;30m'))
  end)

  it('should return true if color is hsl without func', function()
    assert.is_true(patterns.is_hsl_without_func_color(': 240 100% 68%'))
    assert.is_true(patterns.is_hsl_without_func_color(': 150deg 30% 40%'))
    assert.is_true(patterns.is_hsl_without_func_color(': 0.3turn 30% 40%'))
    assert.is_true(patterns.is_hsl_without_func_color(': 150 30% 40%'))
  end)

  it('should return false if color is not hsl without func', function()
    assert.is_false(patterns.is_hsl_without_func_color('#FFF'))
    assert.is_false(patterns.is_hsl_without_func_color('#FFFFFF'))
    assert.is_false(patterns.is_hsl_without_func_color('#FFFFFFFF'))
    assert.is_false(patterns.is_hsl_without_func_color('rgb(255, 255, 255)'))
    assert.is_false(patterns.is_hsl_without_func_color('\033[0;30m'))
    assert.is_false(patterns.is_hsl_without_func_color('hsl(240, 100%, 68%)'))
    assert.is_false(patterns.is_hsl_without_func_color('hsl(150deg 30% 40%)'))
    assert.is_false(patterns.is_hsl_without_func_color('hsl(0.3turn 60% 15%) '))
    assert.is_false(patterns.is_hsl_without_func_color('hsl(240 100% 68%)'))
  end)

  it('should return true if color is css var color', function()
    assert.is_true(patterns.is_var_color('var(--css-color)'))
    assert.is_true(patterns.is_var_color('  var(--css-color)  '))
  end)

  it('should return false if color is not css var color', function()
    assert.is_false(patterns.is_var_color('vr(--css-color)'))
    assert.is_false(patterns.is_var_color('var(-css-color)'))
    assert.is_false(patterns.is_var_color('var(-css-color'))
    assert.is_false(patterns.is_var_color('var(--css%color)'))
    assert.is_false(patterns.is_var_color('#FFF'))
    assert.is_false(patterns.is_var_color('#FFFFFF'))
    assert.is_false(patterns.is_var_color('#FFFFFFFF'))
    assert.is_false(patterns.is_var_color('rgb(255, 255, 255)'))
    assert.is_false(patterns.is_var_color('\033[0;30m'))
  end)

  it('should return true if color is custom color', function()
    assert.is_true(
      patterns.is_custom_color(
        'custom-color',
        { { label = 'custom%-color', color = '#FFFFFF' }, { label = 'custom%-color2', color = '#FFF' } }
      )
    )
  end)

  it('should return false if color is not custom color', function()
    assert.is_false(
      patterns.is_custom_color(
        'custom-color',
        { { label = 'custom%-', color = '#FFFFFF' }, { label = 'custom%-color2', color = '#FFF' } }
      )
    )
    assert.is_false(
      patterns.is_custom_color(
        'customcolor',
        { { label = 'custom%-color', color = '#FFFFFF' }, { label = 'custom%-color2', color = '#FFF' } }
      )
    )
    assert.is_false(patterns.is_custom_color('custom%-color', {}))
  end)

  it('should return true if color is css named color', function()
    assert.is_true(patterns.is_named_color({ utils.get_css_named_color_pattern() }, ': green'))
    assert.is_true(patterns.is_named_color({ utils.get_css_named_color_pattern() }, '= green'))
    assert.is_true(patterns.is_named_color({ utils.get_css_named_color_pattern() }, '=blue'))
  end)

  it('should return false if color is not css named color', function()
    assert.is_false(patterns.is_named_color({ utils.get_css_named_color_pattern() }, 'green'))
    assert.is_false(patterns.is_named_color({ utils.get_css_named_color_pattern() }, ' blue'))
    assert.is_false(patterns.is_named_color({ utils.get_css_named_color_pattern() }, '#FFFFFF'))
  end)

  it('should return true if color is tailwind color', function()
    assert.is_true(patterns.is_named_color({ utils.get_tailwind_named_color_pattern() }, 'bg-white'))
    assert.is_true(patterns.is_named_color({ utils.get_tailwind_named_color_pattern() }, 'text-slate-500'))
    assert.is_true(patterns.is_named_color({ utils.get_tailwind_named_color_pattern() }, 'bg-sky-300'))
  end)

  it('should return false if color is not tailwind color', function()
    assert.is_false(patterns.is_named_color({ utils.get_tailwind_named_color_pattern() }, '#FFFFFF'))
  end)

  it('should return true if color is ansi color', function()
    assert.is_true(patterns.is_ansi_color('\\033[1;37m'))
    assert.is_true(patterns.is_ansi_color('\\033[1;32m'))
  end)

  it('should return false if color is not ansi color', function()
    assert.is_false(patterns.is_ansi_color('\033[1;37m'))
    assert.is_false(patterns.is_ansi_color('\\033[137m'))
    assert.is_false(patterns.is_ansi_color('\\033[1:37m'))
    assert.is_false(patterns.is_ansi_color('\\033[1;37n'))
  end)

  it('should return true if color is oklch', function()
    assert.is_true(patterns.is_oklch_color('oklch(40% 0.268 34.8deg)'))
    assert.is_true(patterns.is_oklch_color('oklch(40% 0.268 34.8deg / 80%)'))
    assert.is_true(patterns.is_oklch_color('oklch(0.4 0.268 34.8)'))
  end)

  it('should return false if color is not oklch', function()
    assert.is_false(patterns.is_oklch_color('#FFF'))
    assert.is_false(patterns.is_oklch_color('rgb(255, 255, 255)'))
    assert.is_false(patterns.is_oklch_color('hsl(240, 100%, 50%)'))
  end)
end)
