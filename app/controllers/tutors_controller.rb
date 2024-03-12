# frozen_string_literal: true

class TutorsController < ApplicationController
  before_action :find_course
  skip_before_action :verify_authenticity_token

  def create
    tutor = @course.tutors.build(permit_tutor_params)
    if tutor.save
      response = { message: t('success', entity: 'Tutor'), tutor_id: tutor.id }
      status = 201
    else
      response = { message: t('failed', entity: 'tutor'), error_message: tutor.errors.full_messages.join(',') }
      status = 422
    end

    render json: response, status: status
  end

  private

  def find_course
    @course = Course.find_by(id: params[:course_id])
    if @course.blank?
      render json: { message: '', error_message: 'Invalid Course' }
      nil
    end
  end

  def permit_tutor_params
    params.permit(:name, :course_id)
  end
end

