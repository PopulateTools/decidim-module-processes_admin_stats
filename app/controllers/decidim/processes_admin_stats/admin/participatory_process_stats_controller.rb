# frozen_string_literal: true

module Decidim
  module ProcessesAdminStats
    module Admin
      class ParticipatoryProcessStatsController < Decidim::ProcessesAdminStats::Admin::ApplicationController
        include Decidim::ParticipatoryProcesses::Admin::Concerns::ParticipatoryProcessAdmin

        def index
          enforce_permission_to :read, :component

          @process_stats = ParticipatoryProcessStatsPresenter.new(
            participatory_process: current_participatory_process
          )
        end
      end
    end
  end
end
