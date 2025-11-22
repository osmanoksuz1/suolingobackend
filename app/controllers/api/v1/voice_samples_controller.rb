module Api
  module V1
    class VoiceSamplesController < ApplicationController
      include ApiResponse

      def create
        voice_sample = VoiceSample.new(voice_sample_params)
        
        if voice_sample.save
          render_json_response(
            status: 'success',
            data: { 
              id: voice_sample.id,
              status: 'uploaded',
              audio_url: url_for(voice_sample.audio_file)
            },
            message: 'Voice sample uploaded successfully',
            http_status: :created
          )
        else
          render_json_response(
            status: 'error',
            message: voice_sample.errors.full_messages.join(', '),
            http_status: :bad_request
          )
        end
      end

      private

      def voice_sample_params
        params.permit(:profile_id, :duration, :audio_file)
      end
    end
  end
end
