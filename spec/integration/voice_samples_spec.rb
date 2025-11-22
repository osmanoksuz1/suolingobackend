require 'swagger_helper'

RSpec.describe 'api/v1/voice_samples', type: :request do
  path '/api/v1/voice_samples' do
    post 'Uploads a voice sample' do
      tags 'Voice Samples'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :profile_id, in: :formData, type: :integer, required: true
      parameter name: :duration, in: :formData, type: :integer, required: true
      parameter name: :audio_file, in: :formData, type: :file, required: true

      response '201', 'voice sample uploaded' do
        let(:profile) { Profile.create(name: 'test', email: 'test@test.com', profile_photo: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')) }
        let(:profile_id) { profile.id }
        let(:duration) { 60 }
        let(:audio_file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_audio.mp3'), 'audio/mpeg') }
        run_test!
      end

      response '400', 'invalid request' do
        let(:profile_id) { nil }
        let(:duration) { nil }
        let(:audio_file) { nil }
        run_test!
      end
    end
  end
end
