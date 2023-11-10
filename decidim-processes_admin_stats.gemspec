# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/processes_admin_stats/version"

Gem::Specification.new do |s|
  s.version = Decidim::ProcessesAdminStats::VERSION
  s.authors = ["Eduardo Martinez Echevarria"]
  s.email = ["eduardomech@gmail.com"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-processes_admin_stats"
  s.required_ruby_version = ">= 2.5"

  s.name = "decidim-processes_admin_stats"
  s.summary = "A decidim processes_admin_stats module"
  s.description = "A Decidim module to include statistics of participatory processes in their admin panel."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::ProcessesAdminStats::DECIDIM_VERSION
end
