require 'swagger_helper'

RSpec.describe 'api/v1/lessons', type: :request do
  path '/api/v1/lessons' do
    post 'Creates a lesson' do
      tags 'Lessons'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :lesson, in: :body, schema: {
        type: :object,
        properties: {
          profile_id: { type: :integer },
          lesson_text: { type: :string },
          difficulty_level: { type: :string, enum: ['beginner', 'intermediate', 'advanced'] }
        },
        required: ['profile_id', 'lesson_text', 'difficulty_level']
      }

      response '201', 'lesson created' do
        let(:profile) { Profile.create(name: 'test', email: 'test@test.com', profile_photo: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')) }
        let(:lesson) { { profile_id: profile.id, lesson_text: 'This is a valid lesson text', difficulty_level: 'beginner' } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:lesson) { { profile_id: nil } }
        run_test!
      end
    end
  end
end
