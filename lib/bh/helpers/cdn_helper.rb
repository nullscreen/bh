module Bh
  # Provides methods to retrieve the URLs of Bootstrap stylesheets and
  # Javascript files from Bootstrap CDN
  # @see http://www.bootstrapcdn.com
  module CdnHelper
    # @return [String] the URL of the Bootstrap CSS file
    # @param [Hash] options the options for which CSS file to retrieve.
    # @option options [String] :version the version of Bootstrap.
    # @option options [String] :scheme the URI scheme to use.
    # @option options [Boolean] :minified whether to use the minified version.
    def bootstrap_css(options = {})
      bootstrap_asset options.merge(name: 'bootstrap', extension: 'css')
    end

    # @return [String] the URL of the Bootstrap Theme CSS file
    # @param [Hash] options the options for which CSS file to retrieve.
    # @option options [String] :version the version of Bootstrap.
    # @option options [String] :scheme the URI scheme to use.
    # @option options [Boolean] :minified whether to use the minified version.
    def bootstrap_theme_css(options = {})
      bootstrap_asset options.merge(name: 'bootstrap-theme', extension: 'css')
    end

    # @return [String] the URL of the Font Awesome CSS file
    # @param [Hash] options the options for which CSS file to retrieve.
    # @option options [String] :version the version of Font Awesome.
    # @option options [String] :scheme the URI scheme to use.
    # @option options [Boolean] :minified whether to use the minified version.
    # @see http://fontawesome.io/get-started/
    def font_awesome_css(options = {})
      font_awesome_asset options.merge(name: 'font-awesome', extension: 'css')
    end

    # @return [String] the URL of the Bootstrap JS file
    # @param [Hash] options the options for which JS file to retrieve.
    # @option options [String] :version the version of Bootstrap.
    # @option options [String] :scheme the URI scheme to use.
    # @option options [Boolean] :minified whether to use the minified version.
    def bootstrap_js(options = {})
      bootstrap_asset options.merge(name: 'bootstrap', extension: 'js')
    end

  private

    # @note if unspecified, the version should match the latest available
    #   version. If that's not the case, it's a bug and should be fixed.
    def bootstrap_asset(options = {})
      options[:version] ||= '3.2.0'
      cdn_asset options.merge(library: 'bootstrap')
    end

    # @note if unspecified, the version should match the latest available
    #   version. If that's not the case, it's a bug and should be fixed.
    def font_awesome_asset(options = {})
      options[:version] ||= '4.2.0'
      cdn_asset options.merge(library: 'font-awesome')
    end

    def cdn_asset(options = {})
      version = options[:version]
      extension = options[:extension]
      name = options[:name]
      library = options[:library]
      name = "#{name}.min" if options.fetch(:minified, true)
      scheme = "#{options[:scheme]}:" if options[:scheme]
      host = '//netdna.bootstrapcdn.com'
      "#{scheme}#{host}/#{library}/#{version}/#{extension}/#{name}.#{extension}"
    end
  end
end