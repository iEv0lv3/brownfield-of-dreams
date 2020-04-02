FactoryBot.define do
  factory :video do
    title         { Faker::Hipster.sentence(word_count: 4) }
    description   { Faker::TvShows::SiliconValley.motto }
    video_id      { Faker::Crypto.md5 }
    thumbnail     { 'https://i.ytimg.com/vi/FcgkfZEv_LI/hqdefault.jpg' }
    tutorial
  end
end
