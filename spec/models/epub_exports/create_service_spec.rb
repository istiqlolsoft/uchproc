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
#

describe EpubExports::CreateService do
  before :once do
    course_with_teacher(active_all: true)
    student_in_course(active_all: true)
  end

  describe "#save" do
    let_once(:create_service) do
      EpubExports::CreateService.new(@course, @student, :epub_export)
    end

    it "sends save & export to epub_export" do
      expect(create_service.offline_export.new_record?).to be_truthy, 'precondition'
      expect(create_service.offline_export).to receive(:export).once.and_return(nil)
      expect(create_service.save).to be_truthy
      expect(create_service.offline_export.new_record?).to be_falsey
    end
  end

  describe "#offline_export" do
    context "when user has an active epub_export" do
      before(:once) do
        @epub_export = @course.epub_exports.create(user: @student)
        @epub_export.export(synchronous: true)
        @service = EpubExports::CreateService.new(@course, @student, :epub_export)
      end

      it "returns said epub_export" do
        expect(@service.offline_export).to eq @epub_export
      end
    end

    context "when user has no active epub_exports" do
      it "returns a new epub_export instance" do
        service = EpubExports::CreateService.new(@course, @student, :epub_export)
        expect(service.offline_export).to be_new_record
      end
    end
  end

  describe "#already_running?" do
    context "when user has an active epub_export" do
      before(:once) do
        @course.epub_exports.create(user: @student).export(synchronous: true)
        @service = EpubExports::CreateService.new(@course, @student, :epub_export)
      end

      it "returns true" do
        expect(@service.already_running?).to be_truthy
      end
    end

    context "when user doesn't have an active epub_export" do
      it "returns true" do
        service = EpubExports::CreateService.new(@course, @student, :epub_export)
        expect(service.already_running?).to be_falsey
      end
    end

    context "when user has an active epub_export and starts a web_zip_export" do
      before(:once) do
        @epub_export = @course.epub_exports.create(user: @student)
        @epub_export.export(synchronous: true)
        @service = EpubExports::CreateService.new(@course, @student, :web_zip_export)
      end

      it "returns false" do
        expect(@service.already_running?).to be_falsey
      end
    end
  end
end
