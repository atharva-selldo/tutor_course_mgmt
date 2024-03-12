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
            'message' => 'Failed to create course',
            'error_message' => "Name can't be blank"
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
            'message' => 'Course successfully created'
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
          params = { page: 0, per_page: 1 }
          get '/courses/index', params: params
          response_body = JSON.parse(response.body)
          expect(response_body).to eq(
            {
              'message' => 'Courses Successfully Retrieved',
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
              'page' => 0,
              'per_page' => 1,
              'total_courses' => 1
            }
          )
        end
      end

      context 'when params are invalid or not present' do
        it 'responds with success message and course details (considering page 0 and per_page 1)' do
          tutor
          get '/courses/index'
          response_body = JSON.parse(response.body)
          expect(response_body).to eq(
            {
              'message' => 'Courses Successfully Retrieved',
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
              'page' => 0,
              'per_page' => 1,
              'total_courses' => 1
            }
          )
        end
      end
    end
  end
end

