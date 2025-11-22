module Api
  module V1
    class LessonsController < ApplicationController
      include ApiResponse

      def create
        lesson = Lesson.new(lesson_params)
        
        if lesson.save
          render_json_response(
            status: 'success',
            data: { 
              id: lesson.id,
              lesson_text: lesson.lesson_text,
              difficulty_level: lesson.difficulty_level
            },
            message: 'Lesson created successfully',
            http_status: :created
          )
        else
          render_json_response(
            status: 'error',
            message: lesson.errors.full_messages.join(', '),
            http_status: :bad_request
          )
        end
      end

      private

      def lesson_params
        params.permit(:profile_id, :lesson_text, :difficulty_level)
      end
    end
  end
end
