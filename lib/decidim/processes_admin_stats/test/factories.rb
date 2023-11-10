# frozen_string_literal: true

require "decidim/core/test/factories"
require "decidim/proposals/test/factories"

FactoryBot.define do
  factory :processes_admin_stats_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :processes_admin_stats).i18n_name }
    manifest_name :processes_admin_stats
    participatory_space { create(:participatory_process, :with_steps) }
  end

  # Add engine factories here
end
