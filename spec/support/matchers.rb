RSpec::Matchers.define :generate do |html|
  match do |helper, options = {}|
    if helper.is_a?(Hash)
      helper, options = helper.keys.first, helper.values.first
    end

    @inline = bh.send helper, *['content', '/', options].compact
    @block = bh.send(helper, *['/', options].compact) { 'content' }

    case html
      when Regexp then @inline.match(html) && @block.match(html)
      else @inline.eql?(html) && @block.eql?(html)
    end
  end
end