RSpec::Matchers.define :generate do |html|
  match do |helper, options = nil|
    if helper.is_a?(Hash)
      helper, options = helper.keys.first, helper.values.first
    end

    if helper == :link_to
      @inline = bh.send helper, *['content', '/', options].compact
      @block = bh.send(helper, *['/', options].compact) { 'content' }
    elsif helper == :dropdown
      @block = bh.send(helper, *['caption', options].compact) { 'content' }
      @inline = @block
    elsif helper == :glyphicon || helper == :icon
      @inline = bh.send helper, *['zoom-in', options].compact
      @block = bh.send helper, *[:zoom_in, options].compact
    elsif helper == :progress_bar
      @inline = bh.send helper, *Array.wrap(options)
      @block = @inline
    elsif helper == :navbar
      @block = bh.send(helper, *[options].compact) { 'content' }
      @inline = @block
    else
      @inline = bh.send helper, *['content', options].compact
      @block = bh.send(helper, *[options].compact) { 'content' }
    end

    case html
      when Regexp then @inline.match(html) && @block.match(html)
      else @inline.eql?(html) && @block.eql?(html)
    end
  end

  failure_message{|actual| "expected #{html}, got #{@inline} and #{@block}"}
end