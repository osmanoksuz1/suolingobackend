require 'swagger_helper'

RSpec.describe 'api/v1/videos', type: :request do
  path '/api/v1/videos/generate' do
    post 'Generates a video' do
      tags 'Videos'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :video_request, in: :body, schema: {
        type: :object,
        properties: {
          profile_id: { type: :integer },
          lesson_id: { type: :integer },
          voice_sample_id: { type: :integer }
        },
        required: ['profile_id', 'lesson_id', 'voice_sample_id']
      }

      response '202', 'video generation started' do
        let(:profile) { Profile.create(name: 'test', email: 'test@test.com', profile_photo: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')) }
        let(:lesson) { Lesson.create(profile: profile, lesson_text: 'This is a valid lesson text', difficulty_level: 'beginner') }
        let(:voice_sample) { VoiceSample.create(profile: profile, duration: 10, audio_file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_audio.mp3'), 'audio/mpeg')) }
        let(:video_request) { { profile_id: profile.id, lesson_id: lesson.id, voice_sample_id: voice_sample.id } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:video_request) { { profile_id: nil } }
        run_test!
      end
    end
  end

  path '/api/v1/videos/{id}/status' do
    get 'Checks video generation status' do
      tags 'Videos'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'status found' do
        let(:profile) { Profile.create(name: 'test', email: 'test@test.com', profile_photo: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')) }
        let(:lesson) { Lesson.create(profile: profile, lesson_text: 'This is a valid lesson text', difficulty_level: 'beginner') }
        let(:voice_sample) { VoiceSample.create(profile: profile, duration: 10, audio_file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_audio.mp3'), 'audio/mpeg')) }
        let(:video) { Video.create(profile: profile, lesson: lesson, voice_sample: voice_sample, status: 'pending') }
        let(:id) { video.id }
        run_test!
      end

      response '404', 'video not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
