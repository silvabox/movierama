require 'rails_helper'

RSpec.describe VotingMailer do
  let(:user) { User.create(name: 'Ben', email: 'ben@example.com') }
  let(:movie) { Movie.create(
                  title: 'The Force Awakens',
                  description: 'Han Solo Yolo',
                  date: '2015-12-17',
                  user: user,
                  liker_count: 20) }

  describe 'voted notification' do
    it 'selects the liked notification when the type is :like' do
      allow(VotingMailer).to receive(:like).and_return 'Liked Email'
      expect(VotingMailer.voted(:like, movie)).to eq 'Liked Email'
    end

    it 'selects the hated notification when the type is :hate' do
      allow(VotingMailer).to receive(:hate).and_return 'Hated Email'
      expect(VotingMailer.voted(:hate, movie)).to eq 'Hated Email'
    end
  end

  describe 'liked notification' do
    let(:email) { VotingMailer.like(movie) }

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
    let(:email) { VotingMailer.hate(movie) }

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
