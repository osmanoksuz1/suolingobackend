module Api
  module V1
    class VideosController < ApplicationController
      include ApiResponse

      def generate
        # Simulate background job by creating video immediately
        video = Video.new(video_params)
        video.status = 'completed' # Simulating immediate completion for testing
        video.video_url = "https://example.com/videos/#{SecureRandom.uuid}.mp4"
        
        if video.save
          render_json_response(
            status: 'success',
            data: { 
              job_id: video.id,
              status_url: status_api_v1_video_url(video)
            },
            message: 'Video generation started',
            http_status: :accepted
          )
        else
          render_json_response(
            status: 'error',
            message: video.errors.full_messages.join(', '),
            http_status: :bad_request
          )
        end
      end

      def status
        video = Video.find(params[:id])
        
        render_json_response(
          status: 'success',
          data: {
            status: video.status,
            video_url: video.status == 'completed' ? video.video_url : nil
          },
          http_status: :ok
        )
      rescue ActiveRecord::RecordNotFound
        render_json_response(
          status: 'error',
          message: 'Video job not found',
          http_status: :not_found
        )
      end

      private

      def video_params
        params.permit(:profile_id, :lesson_id, :voice_sample_id)
      end
    end
  end
end
