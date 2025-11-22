# Clear existing data
Video.destroy_all
Lesson.destroy_all
VoiceSample.destroy_all
Profile.destroy_all

# Create Profiles
puts "Creating Profiles..."
profile1 = Profile.create!(
  name: "John Doe",
  email: "john@example.com"
)
profile1.profile_photo.attach(
  io: File.open(Rails.root.join('spec/fixtures/files/test_image.jpg')),
  filename: 'profile1.jpg',
  content_type: 'image/jpeg'
)

profile2 = Profile.create!(
  name: "Jane Smith",
  email: "jane@example.com"
)
profile2.profile_photo.attach(
  io: File.open(Rails.root.join('spec/fixtures/files/test_image.jpg')),
  filename: 'profile2.jpg',
  content_type: 'image/jpeg'
)

# Create Voice Samples
puts "Creating Voice Samples..."
vs1 = VoiceSample.create!(
  profile: profile1,
  duration: 45
)
vs1.audio_file.attach(
  io: File.open(Rails.root.join('spec/fixtures/files/test_audio.mp3')),
  filename: 'sample1.mp3',
  content_type: 'audio/mpeg'
)

# Create Lessons
puts "Creating Lessons..."
lesson1 = Lesson.create!(
  profile: profile1,
  lesson_text: "Hello, how are you today? This is a beginner lesson.",
  difficulty_level: "beginner"
)

lesson2 = Lesson.create!(
  profile: profile2,
  lesson_text: "Advanced quantum physics concepts explained simply.",
  difficulty_level: "advanced"
)

# Create Videos
puts "Creating Videos..."
Video.create!(
  profile: profile1,
  lesson: lesson1,
  voice_sample: vs1,
  status: "completed",
  video_url: "https://example.com/videos/demo1.mp4"
)

puts "Seeding completed!"
