class Student
  attr_reader  :courses, :last_name, :first_name

  def initialize(first_name, last_name)
    @first_name, @last_name = first_name, last_name
    @courses = []
  end

  def name
    "#{first_name} #{last_name}"
  end

  def courses
    @courses 
  end

  def enroll(course)
    return if courses.include?(course)
    raise "course would cause conflict!" if has_conflict?(course)

    self.courses << course
    course.students << self
  end

  def course_load
    load = Hash.new(0)
    self.courses.each do |course|
      load[course.department] += course.credits
    end
    load
  end

  def has_conflict?(new_course)
    self.courses.any? do |enrolled_course|
      new_course.conflicts_with?(enrolled_course)
    end
  end

end
