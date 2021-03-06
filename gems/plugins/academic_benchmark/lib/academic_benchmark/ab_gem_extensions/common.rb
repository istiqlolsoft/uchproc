# frozen_string_literal: true

#
# Copyright (C) 2015 - present Instructure, Inc.
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

module AcademicBenchmarks
  module Standards
    module Common
      def course_cache
        @course_cache ||= {}
      end

      def subject_cache
        @subject_cache ||= {}
      end

      def build_common_outcomes(ratings)
        course_cache.clear
        subject_cache.clear
        {
          migration_id: guid,
          vendor_guid: guid,
          is_global_standard: true,
          type: 'learning_outcome_group',
          outcomes: children.filter_map { |c| c.build_outcomes(ratings, self) }
        }
      end
    end
  end
end
