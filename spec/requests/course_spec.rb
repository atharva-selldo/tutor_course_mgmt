# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :request do
  let(:tutor) { create(:tutor) }

  describe 'create' do
    context 'when course name is not present' do
      it 'responds with appropriate error message' do
        post '/courses', params: { name: '' }
        response_body = JSON.parse(response.body)
        expect(response_body).to eq(
          {
            'message' => "Name can't be blank"
          }
        )
      end
    end

    context 'when course is present' do
      it 'responds with success message' do
        post '/courses', params: { name: 'demo-course' }
        response_body = JSON.parse(response.body)
        course = Course.first
        expect(response_body).to eq(
          {
            'data' => course.id,
            'message' => 'Course created successfully'
          }
        )
      end
    end
  end

  describe 'index' do
    context 'when course are present' do
      context 'when params are valid' do
        it 'responds with success message and course details' do
          tutor
          params = { page: 1, per_page: 10 }
          get '/courses/', params: params
          response_body = JSON.parse(response.body)
          expect(response_body).to eq(
            {
              'message' => 'Courses retrieved successfully',
              'data' =>
              [
                {
                  'id' => tutor.course.id,
                  'name' => 'test-course',
                  'tutors' => [{
                    'id' => tutor.id,
                    'name' => 'test-tutor'
                  }]
                }
              ],
              'page' => 1,
              'per_page' => 10,
              'total_courses' => 1
            }
          )
        end
      end

      context 'when params are invalid or not present' do
        it 'responds with success message and course details (considering page 1 and per_page 10)' do
          tutor
          get '/courses/'
          response_body = JSON.parse(response.body)
          expect(response_body).to eq(
            {
              'message' => 'Courses retrieved successfully',
              'data' =>
               [
                 {
                   'id' => tutor.course.id,
                   'name' => 'test-course',
                   'tutors' => [{
                     'id' => tutor.id,
                     'name' => 'test-tutor'
                   }]
                 }
               ],
              'page' => 1,
              'per_page' => 10,
              'total_courses' => 1
            }
          )
        end
      end
    end
  end
end

