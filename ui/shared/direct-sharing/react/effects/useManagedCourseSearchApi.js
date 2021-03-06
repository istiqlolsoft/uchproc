/*
 * Copyright (C) 2019 - present Instructure, Inc.
 *
 * This file is part of Canvas.
 *
 * Canvas is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation, version 3 of the License.
 *
 * Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Affero General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import useFetchApi from '@canvas/use-fetch-api-hook'

// The manageable_courses api returns the course name as `label` for some reason
function convertManageableCoursesToApi(courses) {
  return courses.map(course => ({name: course.label, ...course}))
}

export default function useManagedCourseSearchApi(fetchApiOpts = {}, includeConcluded = false) {
  if (!fetchApiOpts.params) {
    fetchApiOpts.params = {}
  }
  if (includeConcluded) {
    fetchApiOpts.params.include = 'concluded'
  }

  // search term of at least 2 characters required
  const searchTerm = fetchApiOpts.params.term || ''
  let forceResult
  if (searchTerm.length < 2) forceResult = null

  useFetchApi({
    path: `/users/self/manageable_courses`,
    convert: convertManageableCoursesToApi,
    forceResult,
    ...fetchApiOpts
  })
}
