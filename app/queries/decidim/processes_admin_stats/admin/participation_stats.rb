# frozen_string_literal: true

module Decidim
  module ProcessesAdminStats
    module Admin
      class ParticipationStats
        attr_accessor(
          :participatory_process,
          :organization,
          :proposals
        )

        def initialize(participatory_process)
          @participatory_process = participatory_process
          @organization = participatory_process.organization
          @proposals = ::Decidim::Proposals::Proposal.where(decidim_component_id: participatory_process.components.pluck(:id))
        end

        def stats
          [
            {
              name: "total_registered",
              count: total_users_count,
              percentage: percentage(total_users_count, total_users_count)
            },
            {
              name: "total_verified",
              count: verified_users_count,
              percentage: percentage(verified_users_count, total_users_count)
            },
            {
              name: "active_users",
              count: active_users_count,
              percentage: percentage(active_users_count, total_users_count),
              relative_percentage: percentage(active_users_count, active_users_count)
            },
            {
              name: "voting_users",
              count: proposals_voters_count,
              percentage: percentage(proposals_voters_count, total_users_count),
              relative_percentage: percentage(proposals_voters_count, active_users_count)
            },
            {
              name: "not_voting_users",
              count: proposals_not_voters_count,
              percentage: percentage(proposals_not_voters_count, total_users_count),
              relative_percentage: percentage(active_users_count - proposals_voters_count, active_users_count)
            },
            {
              name: "total_votes",
              count: proposals_votes_count,
              percentage: nil,
              relative_percentage: nil
            }
          ]
        end

        private

        def total_users_count
          @total_users_count ||= metric_last_value("users")
        end

        def verified_users_count
          @verified_users_count ||= authorizations.where(
            "decidim_authorizations.created_at <= ?", last_metric_timestamp
          ).count
        end

        def active_users_count
          @active_users_count ||= metric_last_value("participants", participatory_process: participatory_process)
        end

        def proposals_voters_count
          @proposals_voters_count ||= votes.pluck(:decidim_author_id).uniq.size
        end

        def proposals_not_voters_count
          @proposals_not_voters_count ||= total_users_count - proposals_voters_count
        end

        def proposals_votes_count
          @proposals_votes_count ||= votes.count
        end

        def metric_last_value(metric_type, params = {})
          metric_attrs = {
            organization: organization,
            metric_type: metric_type
          }

          metric_attrs[:participatory_space] = participatory_process if params[:participatory_process]

          Decidim::Metric.where(metric_attrs).order(day: :desc).first&.cumulative || 0
        end

        def percentage(part_count, total_count)
          return nil unless part_count && total_count&.positive?

          ((part_count * 100.0) / total_count).round
        end

        def last_metric_timestamp
          Time.zone.yesterday.end_of_day
        end

        def votes
          @votes ||= ::Decidim::Proposals::ProposalVote.where(proposal: proposals)
                                                       .where("created_at <= ?", last_metric_timestamp) # active_users metric is only available until yesterday
        end

        def authorizations
          Decidim::Authorization.joins("INNER JOIN #{Decidim::User.table_name} ON decidim_user_id = decidim_users.id")
            .where("decidim_organization_id = ?", organization.id)
        end
      end
    end
  end
end
