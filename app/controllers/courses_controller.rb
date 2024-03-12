# frozen_string_literal: true

class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    course = Course.new(permit_course_params)
    if course.save
      response = { message: t('success', entity: 'Course'), data: course.id }
      status = 201
    else
      response = { message: course.errors.full_messages.join(',') }
      status = 422
    end

    render json: response, status: status
  end

  def index
    permitted_params = permit_course_params
    page = permitted_params[:page].to_i.positive? ? permitted_params[:page].to_i : 1
    per_page = permitted_params[:per_page].to_i
    per_page = per_page.positive? && per_page <= 10 ? per_page : 10
    courses = []
    total_courses = Course.count
    Course.includes(:tutors).paginate(:page => page, :per_page => per_page).map do |course|
      course_details = course.as_json(except: %i[created_at updated_at])
      course_details[:tutors] = course.tutors.as_json(except: %i[course_id updated_at created_at])
      courses << course_details
    end

    render json: {
      message: t('course_list_success'),
      data: courses,
      total_courses: total_courses,
      page: page,
      per_page: per_page
    }
  end

  private

  def permit_course_params
    case params[:action]
    when 'create'
      params.permit(:name)
    when 'index'
      params.permit(:page, :per_page)
    end
  end
end

