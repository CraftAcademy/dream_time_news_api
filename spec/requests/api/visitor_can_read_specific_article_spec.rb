RSpec.describe 'GET/api/articles', type: :request do
  let(:article) { create(:article) }

  describe 'GET/api/articles' do
    before { get "/api/articles/#{article.id}" }

    it 'is expected to return 200 status' do
      expect(response).to have_http_status 200
    end
    it 'is expected to return title of the article' do
      expect(response_json['article']['title']).to eq 'MyString'
    end
    it 'is expected to return subtitle of the article' do
      expect(response_json['article']['sub_title']).to eq 'MyText'
    end
    it 'is expected to return content of the article' do
      expect(response_json['article']['content']).to eq 'MyText'
    end
    it 'is expected to return author of the article' do
      expect(response_json['article']['author']).to eq 'user@example.com'
    end
  end

  describe 'unsuccessfuly get a specific article' do
    before { get '/api/articles/abc' }

    it 'expected to return a 404 response' do
      expect(response).to have_http_status 404
    end

    it 'is expected to respond with an error message' do
      expect(response_json['message']).to eq 'No article found'
    end
  end
end
