module Api
  module V1
    class ProfilesController < ApplicationController
      include ApiResponse

      def create
        profile = Profile.new(profile_params)
        
        if profile.save
          render_json_response(
            status: 'success',
            data: { 
              id: profile.id,
              name: profile.name,
              email: profile.email,
              profile_photo_url: url_for(profile.profile_photo)
            },
            message: 'Profile created successfully',
            http_status: :created
          )
        else
          render_json_response(
            status: 'error',
            message: profile.errors.full_messages.join(', '),
            http_status: :bad_request
          )
        end
      end

      def show
        profile = Profile.find(params[:id])
        
        render_json_response(
          status: 'success',
          data: {
            id: profile.id,
            name: profile.name,
            email: profile.email,
            profile_photo_url: profile.profile_photo.attached? ? url_for(profile.profile_photo) : nil,
            voice_samples: profile.voice_samples.map { |vs| 
              {
                id: vs.id,
                duration: vs.duration,
                audio_url: vs.audio_file.attached? ? url_for(vs.audio_file) : nil
              }
            }
          },
          http_status: :ok
        )
      rescue ActiveRecord::RecordNotFound
        render_json_response(
          status: 'error',
          message: 'Profile not found',
          http_status: :not_found
        )
      end

      private

      def profile_params
        params.permit(:name, :email, :profile_photo)
      end
    end
  end
end
