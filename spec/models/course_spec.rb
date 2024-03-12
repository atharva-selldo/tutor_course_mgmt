# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { build(:course) }

  describe 'validations' do
    it 'validates correct parameters' do
      course.validate
      expect(course.errors.blank?).to eq(true)
    end

    it 'validates presence of name' do
      course.name = nil
      course.validate
      expect(course.errors.messages[:name]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs_to course' do
      course_relation = Course.reflect_on_association(:tutors)
      expect(course_relation.macro).to eq(:has_many)
    end
  end
end

