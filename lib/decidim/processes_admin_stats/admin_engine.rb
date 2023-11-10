# frozen_string_literal: true

module Decidim
  module ProcessesAdminStats
    # This is the engine that runs on the public interface of `ProcessesAdminStats`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::ProcessesAdminStats::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        resources :participatory_processes, param: :slug, except: [:show, :destroy] do
          resources :stats, controller: "participatory_process_stats", only: [:index]
        end
      end

      initializer "decidim_processes_admin_stats.mount_routes", before: "decidim_admin.mount_routes" do
        # Mount the engine routes to Decidim::Core::Engine because otherwise
        # they would not get mounted properly.
        Decidim::Admin::Engine.routes.append do
          mount Decidim::ProcessesAdminStats::AdminEngine => "/"
        end
      end

      initializer "decidim_processes_admin.admin_process_add_stats" do
        Decidim.menu :admin_participatory_process_menu do |menu|
          menu.add_item :stats,
            I18n.t("stats", scope: "decidim.processes_admin_stats.admin.menu.participatory_processes_submenu"),
            decidim_processes_admin_stats_admin.participatory_process_stats_path(current_participatory_space),
            active: is_active_link?(decidim_processes_admin_stats_admin.participatory_process_stats_path(current_participatory_space)),
            icon_name: "line-chart-line",
            if: allowed_to?(:read, :component)
        end
      end

      def load_seed
        nil
      end
    end
  end
end
