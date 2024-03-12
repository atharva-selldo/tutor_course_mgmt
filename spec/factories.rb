# frozen_string_literal: true

FactoryBot.define do
  factory :course, class: Course do
    name { 'test-course' }
  end

  factory :tutor, class: Tutor do
    name { 'test-tutor' }
    course
  end
end

