# This code is copied from ActiveAdmin version 0.6.0
# Version 0.5.1 currently defined for this app, only checks whether
# @download_links is false, and does not allow you to specify which
# download links are shown.

require 'active_admin/helpers/collection'

module ActiveAdmin
  module Views
    class PaginatedCollection < ActiveAdmin::Component
     protected

      def build_pagination_with_formats(options)
        div :id => "index_footer" do
          build_pagination
          div(page_entries_info(options).html_safe, :class => "pagination_information")

          if @download_links.is_a?(Array) && !@download_links.empty?
            build_download_format_links @download_links
          else
            build_download_format_links unless @download_links == false
          end

        end
      end
    end
  end
end
