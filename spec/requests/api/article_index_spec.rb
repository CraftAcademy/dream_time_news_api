RSpec.describe "GET /api/articles", type: :request do
  let(:journalist) { create(:user, role: "journalist") }
  let(:journalist_headers) { journalist.create_new_auth_token }
  let!(:articles){5.times{create(:article, author_id: journalist.id)}}

  describe "GET /api/articles" do
    before do
      get "/api/articles"
    end

    it "is expected to return 200 status" do
      expect(response).to have_http_status 200
    end

    it "is expected to return a collection of articles" do
      expect(response_json["articles"].count).to eq 5
    end

    it "is expected that every article has an author" do 
      expect(response_json["articles"][0]["author"]).to eq journalist.email
    end

    it "is expected to return a article with an title" do
      expect(response_json["articles"][0]["title"]).to eq "MyString"
    end

    it "is expected to return a article with an subtitle" do
      expect(response_json["articles"][0]["sub_title"]).to eq "MyText"
    end

    it "is expected to return a article with content" do
      expect(response_json["articles"][0]["content"]).to eq "MyText"
    end
  end
end