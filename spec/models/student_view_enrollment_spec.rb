# frozen_string_literal: true

#
# Copyright (C) 2011 - present Instructure, Inc.
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

describe StudentViewEnrollment do
  before do
    @student = User.create(:name => "some student")
    @course = Course.create(:name => "some course")
    @se = @course.enroll_student(@student)
    @assignment = @course.assignments.create!(:title => 'some assignment')
    @submission = @assignment.submit_homework(@student)
    @assignment.reload
    @course.save!
    @se = @course.student_enrollments.first
  end

  it "belongs to a student" do
    @se.reload
    @student.reload
    expect(@se.user_id).to eql(@student.id)
    expect(@se.user).to eql(@student)
    expect(@se.user.id).to eql(@student.id)
  end
end
