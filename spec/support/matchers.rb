RSpec::Matchers.define :generate do |html|
  match do |helper, options = {}|
    if helper.is_a?(Hash)
      helper, options = helper.keys.first, helper.values.first
    end

    if helper == :link_to
      @inline = bh.send helper, *['content', '/', options].compact
      @block = bh.send(helper, *['/', options].compact) { 'content' }
    elsif helper == :dropdown
      @block = bh.send(helper, *['caption', options].compact) { 'content' }
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