# frozen_string_literal: true

# https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
# https://medium.com/selleo/essential-rubyonrails-patterns-part-1-service-objects-1af9f9573ca1
# https://codeclimate.com/blog/7-ways-to-decompose-fat-activerecord-models/sS
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
