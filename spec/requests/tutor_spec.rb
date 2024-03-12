# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutor, type: :request do
  let(:course){ create(:course) }

  describe '#create' do
    context 'when tutor params are invalid' do
      context 'when tutor name is not present' do
        it 'responds with appropriate error message' do
          course
          post '/tutors', params: { name: '', course_id: course.id }
          response_body = JSON.parse(response.body)
          expect(response_body).to eq(
            {
              "message" => "Failed to create tutor",
              "error_message" => "Name can't be blank"
            }
          )
        end
      end

      context 'when course is not present' do
        it 'responds with appropriate error message' do
          post '/tutors', params: { name: '', course_id: 10 }
          response_body = JSON.parse(response.body)
          expect(response_body).to eq(
            {
              "error_message" => "Invalid Course",
              "message" => ""
            }
          )
        end
      end
    end

    context 'when tutor params are valid' do
      it 'responds with appropriate success message' do
        course
        post '/tutors', params: { name: 'demo-tutor', course_id: course.id }
        response_body = JSON.parse(response.body)
        tutor = Tutor.first
        expect(response_body).to eq(
          {
            "message" => "Tutor successfully created",
            "tutor_id" => tutor.id
          }
        )
      end
    end
  end
end

