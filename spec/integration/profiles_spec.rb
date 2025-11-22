require 'swagger_helper'

RSpec.describe 'api/v1/profiles', type: :request do
  path '/api/v1/profiles' do
    post 'Creates a profile' do
      tags 'Profiles'
      consumes 'multipart/form-data'
      produces 'application/json'
      
      parameter name: :name, in: :formData, type: :string, required: true
      parameter name: :email, in: :formData, type: :string, required: true
      parameter name: :profile_photo, in: :formData, type: :file, required: true

      response '201', 'profile created' do
        schema type: :object,
          properties: {
            status: { type: :string },
            data: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string },
                email: { type: :string },
                profile_photo_url: { type: :string }
              }
            },
            message: { type: :string },
            timestamp: { type: :string }
          }

        let(:name) { 'John Doe' }
        let(:email) { 'john@example.com' }
        let(:profile_photo) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg') }
        run_test!
      end

      response '400', 'invalid request' do
        let(:name) { '' }
        let(:email) { 'invalid' }
        let(:profile_photo) { nil }
        run_test!
      end
    end
  end

  path '/api/v1/profiles/{id}' do
    get 'Retrieves a profile' do
      tags 'Profiles'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'profile found' do
        schema type: :object,
          properties: {
            status: { type: :string },
            data: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string },
                email: { type: :string },
                voice_samples: { type: :array }
              }
            }
          }

        let(:id) { Profile.create(name: 'test', email: 'test@test.com', profile_photo: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')).id }
        run_test!
      end

      response '404', 'profile not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
