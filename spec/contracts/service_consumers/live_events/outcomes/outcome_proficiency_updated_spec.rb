# frozen_string_literal: true

#
# Copyright (C) 2021 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

require_relative '../live_events_pact_helper'

RSpec.describe 'Canvas LMS Live Events', :pact_live_events do
  describe 'outcome_proficiency_updated' do
    let(:live_event) do
      LiveEvents::PactHelper::Event.new(
        event_name: 'outcome_proficiency_updated',
        event_subscriber: PactConfig::LiveEventConsumers::OUTCOMES
      )
    end

    it 'keeps the contract' do
      live_event.emit_with do
        proficiency = outcome_proficiency_model(course_model)
        ratings = proficiency.outcome_proficiency_ratings
        ratings.first.update!(mastery: false)
        ratings.last.update!(mastery: true)
        proficiency.update!(outcome_proficiency_ratings: ratings)
      end

      expect(live_event).to have_kept_the_contract
    end
  end
end
