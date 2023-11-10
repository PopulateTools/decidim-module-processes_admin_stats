# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module ProcessesAdminStats
    # This is the engine that runs on the public interface of processes_admin_stats.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::ProcessesAdminStats

      routes do
        # Add engine routes here
        # resources :processes_admin_stats
        # root to: "processes_admin_stats#index"
      end
    end
  end
end
