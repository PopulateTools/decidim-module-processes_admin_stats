# Decidim::ProcessesAdminStats

A Decidim module to include statistics of participatory processes in their admin panel.

## Usage
After [installing](#installation) this module a new item in the admin menu of each participatory process is created which links to a table with stats of the process

#### Decidim 0.26

![Admin participatory process screenshot 0.26](https://github.com/PopulateTools/decidim-module-processes_admin_stats/assets/446459/80b81783-6a89-468f-b00c-b7065fda9659)

#### Decidim 0.28

![Admin participatory process screenshot 0.28](https://github.com/PopulateTools/decidim-module-processes_admin_stats/assets/446459/6c113e8f-3588-49eb-a433-c090fbee5892)

## Installation

This module is compatible with Decidim 0.26 and higher.

Add this line to your application's Gemfile:

```ruby
gem "decidim-processes_admin_stats", git: "https://github.com/PopulateTools/decidim-module-processes_admin_stats.git", branch: "main"
```

And then execute:

```bash
bundle
```

The last version of this module is compatible with Decidim version 0.26 or higher. Currently it has been tested that the module works fine with 0.28 Decidim version.

| ProcessAdminStats version | Compatible Decidim versions |
|---|---|
| 0.26.0 | ~> 0.26.x |
| 0.28.0 | >= 0.26.0 |

### Testing

To run the tests run the following in the gem development path:

```bash
bundle
DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rake test_app
DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rspec
```

## Contributing

See [Decidim](https://github.com/decidim/decidim).

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
