# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { "title" }
    memo { "memo" }
    picture { "picture" }
    author { "author" }
  end
end
