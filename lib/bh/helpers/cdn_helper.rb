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

    # @return [String] the URL of the Bootstrap JS file
    # @param [Hash] options the options for which JS file to retrieve.
    # @option options [String] :version the version of Bootstrap.
    # @option options [String] :scheme the URI scheme to use.
    # @option options [Boolean] :minified whether to use the minified version.
    def bootstrap_js(options = {})
      bootstrap_asset options.merge(name: 'bootstrap', extension: 'js')
    end

  private

    # @return [String] the version of Bootstrap assets to use if unspecified.
    def bootstrap_version
      '3.2.0'
    end

    def bootstrap_asset(options = {})
      version = options.fetch :version, bootstrap_version
      extension = options[:extension]
      name = options[:name]
      name = "#{name}.min" if options.fetch(:minified, true)
      scheme = "#{options[:scheme]}:" if options[:scheme]
      host = '//netdna.bootstrapcdn.com'
      "#{scheme}#{host}/bootstrap/#{version}/#{extension}/#{name}.#{extension}"
    end
  end
end