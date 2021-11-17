require 'atom'
class CourseExt < ActiveRecord::Base
  belongs_to :course

  def self.point_kvd(course_id)
    course_ext = CourseExt.where(:course_id => course_id).first
    kvd = nil
    if course_ext
      kvd = course_ext.isu_tblvdkr_id
    end
    kvd
  end
  def self.attendance_kvd(course_id)
    course_ext = CourseExt.where(:course_id => course_id).first
    kvd = nil
    if course_ext
      kvd = course_ext.isu_tblvdtkr_id
    end
    kvd
  end
end

