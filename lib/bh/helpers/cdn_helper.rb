require 'bh/classes/cdn'

module Bh
  module Helpers
    # @see http://www.bootstrapcdn.com
    # @return [String] the URL of the Bootstrap CSS file
    # @param [Hash] options the options for which CSS file to retrieve.
    # @option options [String] :version the version of Bootstrap.
    # @option options [String] :scheme the URI scheme to use.
    # @option options [Boolean] :minified whether to use the minified version.
    def bootstrap_css(options = {})
      Bh::Cdn.bootstrap options.merge(name: 'bootstrap', extension: 'css')
    end

    # @see http://www.bootstrapcdn.com
    # @return [String] the URL of the Bootstrap Theme CSS file
    # @param [Hash] options the options for which CSS file to retrieve.
    # @option options [String] :version the version of Bootstrap.
    # @option options [String] :scheme the URI scheme to use.
    # @option options [Boolean] :minified whether to use the minified version.
    def bootstrap_theme_css(options = {})
      Bh::Cdn.bootstrap options.merge(name: 'bootstrap-theme', extension: 'css')
    end

    # @see http://www.bootstrapcdn.com
    # @return [String] the URL of the Font Awesome CSS file
    # @param [Hash] options the options for which CSS file to retrieve.
    # @option options [String] :version the version of Font Awesome.
    # @option options [String] :scheme the URI scheme to use.
    # @option options [Boolean] :minified whether to use the minified version.
    # @see http://fontawesome.io/get-started/
    def font_awesome_css(options = {})
      Bh::Cdn.font_awesome options.merge(name: 'font-awesome', extension: 'css')
    end

    # @see http://www.bootstrapcdn.com
    # @return [String] the URL of the Bootstrap JS file
    # @param [Hash] options the options for which JS file to retrieve.
    # @option options [String] :version the version of Bootstrap.
    # @option options [String] :scheme the URI scheme to use.
    # @option options [Boolean] :minified whether to use the minified version.
    def bootstrap_js(options = {})
      Bh::Cdn.bootstrap options.merge(name: 'bootstrap', extension: 'js')
    end
  end
end