# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeolocationController, type: :controller do
  let(:payload) { { ip: '127.0.0.1' } }

  before do
    authenticate_request(payload)
  end

  shared_examples 'a private end point' do
    before do
      request.headers['Authorization'] = 'random'
    end

    it 'returns unauthorized' do
      expect(subject).to have_http_status(:unauthorized)
    end
  end

  describe 'POST #add' do
    subject(:post_add) { post :add, params: payload }

    context 'when geolocation does not exist' do
      before do
        allow(Geolocation).to receive(:find_by).and_return(nil)
        allow_any_instance_of(GeolocationProviderService).to receive(:lookup).and_return({})
      end

      it 'creates a new geolocation' do
        post_add
        expect(response).to have_http_status(:created)
      end
    end

    context 'when geolocation already exists' do
      before do
        allow(Geolocation).to receive(:find_by).and_return(double)
      end

      it 'returns unprocessable_entity status' do
        post_add
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it_behaves_like 'a private end point'
  end

  describe 'DELETE #delete' do
    subject(:delete_geolocation) { delete :delete, params: payload }
    context 'when geolocation exists' do
      before do
        allow(Geolocation).to receive(:find_by).and_return(double(destroy: true))
      end

      it 'deletes the geolocation' do
        delete_geolocation
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when geolocation does not exist' do
      before do
        allow(Geolocation).to receive(:find_by).and_return(nil)
      end

      it 'returns not_found status' do
        delete_geolocation
        expect(response).to have_http_status(:not_found)
      end
    end

    it_behaves_like 'a private end point'
  end

  describe 'GET #retrieve' do
    subject(:retrieve_geolocation) { get :retrieve, params: payload }

    let(:location) do
      {
        "ip": '134.201.250.157',
        "type": 'ipv4',
        "continent_code": 'NA',
        "continent_name": 'North America',
        "country_code": 'US',
        "country_name": 'United States',
        "region_code": 'CA'
    }.to_json
    end
    context 'when geolocation exists' do
      before do
        allow(Geolocation).to receive(:find_by).and_return(double(ip: '127.0.0.1', location: location))
      end

      it 'returns the geolocation' do
        retrieve_geolocation
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when geolocation does not exist' do
      before do
        allow(Geolocation).to receive(:find_by).and_return(nil)
      end

      it 'returns not_found status' do
        retrieve_geolocation
        expect(response).to have_http_status(:not_found)
      end
    end

    it_behaves_like 'a private end point'
  end
end
