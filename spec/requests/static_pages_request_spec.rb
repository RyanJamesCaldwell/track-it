require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe "GET root" do
    context '' do
      let(:track_it_pitch) { 'TrackIT is a free and open source issue tracker for software development teams.' }
      it 'returns http success' do
        get root_url
        expect(response.body).to include(track_it_pitch)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
