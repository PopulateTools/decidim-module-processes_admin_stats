# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

source "https://rubygems.org"
require "decidim/processes_admin_stats/version"

ruby RUBY_VERSION
DECIDIM_VERSION = Decidim::ProcessesAdminStats::DECIDIM_VERSION
EDGE_VERSION = { git: "https://github.com/decidim/decidim.git", branch: "develop" }

gem "decidim", EDGE_VERSION
gem "decidim-processes_admin_stats", path: "."

gem "bootsnap", require: false
gem "puma", ">= 4.3"
gem "uglifier", "~> 4.1"
gem "deface"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", EDGE_VERSION
end

group :development do
  gem "faker", "~> 3.2"
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end
