require 'rails_helper'

RSpec.describe UserMailer do
  let(:user) { User.create(name: 'Ben', email: 'ben@example.com') }
  let(:movie) { Movie.create(
                  title: 'The Force Awakens',
                  description: 'Han Solo Yolo',
                  date: '2015-12-17',
                  user: user,
                  liker_count: 20) }

  describe 'likes notification' do
    let(:email) { UserMailer.liked(movie) }

    before do
      email.deliver
    end

    it 'sends to the user associated to the user' do
      expect(email.to).to include user.email
    end

    it 'greets the user' do
      expect(email.body.to_s).to include "Hi #{user.name}"
    end

    it 'contains the name of the movie' do
      expect(email.body.to_s).to include movie.title
    end
  end

  describe 'hated notification' do
    let(:email) { UserMailer.hated(movie) }

    it "sends to the movie's associated user" do
      expect(email.to).to include user.email
    end

    it 'greets the user' do
      expect(email.body.to_s).to include "Hi #{user.name}"
    end

    it 'contains the name of the movie' do
      expect(email.body.to_s).to include movie.title
    end
  end
end
