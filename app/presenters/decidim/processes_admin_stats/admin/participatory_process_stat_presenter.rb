# frozen_string_literal: true

module Decidim
  module ProcessesAdminStats
    module Admin
      class ParticipatoryProcessStatPresenter < SimpleDelegator
        delegate :content_tag, :safe_join, :number_with_delimiter, to: :view_context

        def view_context
          @view_context ||= __getobj__.fetch(:view_context, ActionController::Base.new.view_context)
        end

        %i[name count percentage relative_percentage].each do |attr|
          define_method attr do
            __getobj__.fetch(attr, nil)
          end
        end

        def present
          content_tag(:tr, id: "process-stat-#{name}") do
            content_tag(:td, I18n.t(name, scope: "decidim.processes_admin_stats.stats.participatory_processes")) +
              content_tag(:td, number_with_delimiter(count)) +
              percentage_content +
              relative_percentage_content
          end
        end

        private

        def percentage_content
          percentage ? content_tag(:td, "#{percentage} %") : content_tag(:td, "-")
        end

        def relative_percentage_content
          relative_percentage ? content_tag(:td, "#{relative_percentage} %") : content_tag(:td, "-")
        end
      end
    end
  end
end
