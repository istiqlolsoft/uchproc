/*
 * Copyright (C) 2021 - present Instructure, Inc.
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

import React from 'react'
import {render} from '@testing-library/react'
import ScoresGrid from '../ScoresGrid'

describe('ScoresGrid', () => {
  const defaultProps = (props = {}) => {
    return {
      rollups: [
        {
          studentId: '1',
          outcomeRollups: [
            {
              outcomeId: '1',
              rating: {
                points: 3,
                color: 'green',
                description: 'mastery'
              }
            }
          ]
        }
      ],
      students: [
        {
          id: '1',
          name: 'Student Name',
          display_name: 'Student Name'
        }
      ],
      outcomes: [
        {
          id: '1',
          title: 'Outcome Title',
          mastery_points: 3,
          ratings: [
            {
              points: 5,
              color: 'green',
              description: 'Description',
              mastery: true
            }
          ]
        }
      ],
      ...props
    }
  }

  it('renders each outcome rollup', () => {
    const {getByText} = render(<ScoresGrid {...defaultProps()} />)
    expect(getByText(/mastery/)).toBeInTheDocument()
  })
})