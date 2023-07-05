FactoryBot.define do
    factory :post do
        user
        title { "Test title" }
        description { "Test description" }
        image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image.png'), 'image/png') }
    end
end