# frozen_string_literal: true

require_relative '../services/geolocation_provider'

# GeolocationController handles add, delete, and retrieve operations for geolocation data,
# interacting with a GeolocationProviderService.
class GeolocationController < ApplicationController
  before_action :authorize_request

  ERRORS = {
    geolocation_save_error: {
      status: :unprocessable_entity,
      message: 'Failed to save geolocation'
    },
    geolocation_does_not_exist: {
      status: :not_found,
      message: "Geolocation doesn't exist"
    },
    geolocation_delete_error: {
      status: :unprocessable_entity,
      message: 'Something went wrong. The geolocation cannot be deleted'
    },
    geolocation_not_found: {
      status: :not_found,
      message: 'Geolocation not found'
    },
    ip_taken: {
      status: :unprocessable_entity,
      message: 'IP already exist'
    }
  }.freeze

  def add
    return if ip_taken?(params[:ip])

    response = GeolocationProviderService.new.lookup(params[:ip])
    return handle_error(response['error']) if response['error'].present?

    if Geolocation.new(ip: params[:ip], location: response).save
      render json: { message: 'Geolocation saved', geolocation: response }, status: :created
    else
      handle_error(:geolocation_save_error)
    end
  end

  def delete
    geolocation = Geolocation.find_by(ip: params[:ip])
    return handle_error(:geolocation_does_not_exist) if geolocation.blank?

    if geolocation.destroy
      render json: { message: "IP '#{params[:ip]}' successfully deleted" }
    else
      render_error(:geolocation_delete_error)
    end
  end

  def retrieve
    geolocation = Geolocation.find_by(ip: params[:ip])
    if geolocation
      render json: { ip: geolocation.ip, location: eval(geolocation.location) }
    else
      handle_error(:geolocation_not_found)
    end
  end

  private

  def ip_taken?(ip)
    handle_error(:ip_taken) if Geolocation.find_by(ip:)
  end

  def handle_error(error_code)
    error_details = ERRORS[error_code] || { message: error_code, status: :unprocessable_entity }
    render json: { error: error_details[:message] }, status: error_details[:status]
  end
end
