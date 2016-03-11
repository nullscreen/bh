require 'bh/classes/base'

module Bh
  module Classes
    # @api private
    class Cdn
      # @note if unspecified, the version should match the latest available
      #   version. If that's not the case, it's a bug and should be fixed.
      def self.bootstrap(options = {})
        options[:version] ||= '3.3.6'
        cdn_asset options.merge(library: 'bootstrap')
      end

      # @note if unspecified, the version should match the latest available
      #   version. If that's not the case, it's a bug and should be fixed.
      def self.font_awesome(options = {})
        options[:version] ||= '4.5.0'
        cdn_asset options.merge(library: 'font-awesome')
      end

    private

      def self.cdn_asset(options = {})
        version = options[:version]
        extension = options[:extension]
        name = options[:name]
        name = "#{name}.min" if options.fetch(:minified, true)
        library = options[:library]
        scheme = "#{options[:scheme]}:" if options[:scheme]
        host = "#{scheme}//netdna.bootstrapcdn.com"
        "#{host}/#{library}/#{version}/#{extension}/#{name}.#{extension}"
      end
    end
  end
end