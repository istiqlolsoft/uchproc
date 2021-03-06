# frozen_string_literal: true

#
# Copyright (C) 2020 Instructure, Inc.
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
class DataServicesCanvasLoader
  JSON_BASE_PATH = 'doc/api/data_services/json/canvas'

  def self.data
    @@data ||= DataServicesEventsLoader.new(JSON_BASE_PATH).data
  end

  def self.metadata
    @@metadata ||= {
      examples: JSON.parse(File.read("#{JSON_BASE_PATH}/metadata.json"))
    }
  end
end
