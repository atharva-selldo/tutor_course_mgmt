# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutor, type: :model do
  let(:tutor) { build(:tutor) }

  describe 'validations' do
    it 'validates correct parameters' do
      tutor.validate
      expect(tutor.errors.blank?).to eq(true)
    end

    it 'validates presence of name' do
      tutor.name = nil
      tutor.validate
      expect(tutor.errors.messages[:name]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs_to course' do
      course_relation = Tutor.reflect_on_association(:course)
      expect(course_relation.macro).to eq(:belongs_to)
    end
  end
end

