# frozen_string_literal: true

module Decidim
  module ProcessesAdminStats
    module Admin
      # A presenter to render statistics in the process admin page.
      class ParticipatoryProcessStatsPresenter < SimpleDelegator
        delegate :content_tag, :safe_join, to: :view_context

        def view_context
          @view_context ||= __getobj__.fetch(:view_context, ActionController::Base.new.view_context)
        end

        def participatory_process
          __getobj__.fetch(:participatory_process)
        end

        def headers
          content_tag(:tr) do
            safe_join(
              stats_headers.map do |column|
                content_tag(:th) { column }
              end
            )
          end
        end

        def values
          safe_join(
            process_stats.map do |stat|
              Admin::ParticipatoryProcessStatPresenter.new(stat).present
            end
          )
        end

        private

        def process_stats
          Admin::ParticipationStats.new(participatory_process).stats
        end

        def stats_headers
          %w(metric value total_percentage active_percentage).map do |key|
            I18n.t(key, scope: "decidim.processes_admin_stats.stats.participatory_processes")
          end
        end
      end
    end
  end
end
