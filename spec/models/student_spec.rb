require 'spec_helper'

FactoryGirl.define do
  factory :student do
    sequence(:name) {|n| "Student Name #{n}"}
    sequence(:email) {|n| "test-#{n}@example.com"}
    password "password"
    password_confirmation "password"
  end
end

describe Student do
  let(:now) { Date.today }

  describe ".in_seat" do
    let!(:student_in_seat_1) do
      attendance = create(:attendance, attended_on: now, seat: 1)
      create(:student, attendances: [attendance])
    end

    let!(:student_in_seat_2) do
      attendance = create(:attendance, attended_on: now, seat: 2)
      create(:student, attendances: [attendance])
    end

    let!(:absent_student) do
      attendance = create(:attendance, attended_on: now - 1.day, seat: 1)
      create(:student, attendances: [attendance])
    end

    specify do
      students = Student.in_seat(1, now)
      expect(students).to include(student_in_seat_1)
      expect(students).to_not include(student_in_seat_2)
      expect(students).to_not include(absent_student)
    end
  end

  describe ".absent" do
    let!(:present_student) do
      attendance = create(:attendance, attended_on: now, seat: 1)
      create(:student, attendances: [attendance])
    end

    let!(:absent_student) do
      attendance = create(:attendance, attended_on: now - 1.day, seat: 1)
      create(:student, attendances: [attendance])
    end

    specify do
      students = Student.absent(now)
      expect(students).to include(absent_student)
      expect(students).to_not include(present_student)
    end
  end
end