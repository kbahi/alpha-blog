require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
    
    def setup
        @user = User.create(username: "john", email: "john@doe.com", password: "password", admin: true)
    end
    
    test "create new article" do
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        assert_difference 'Article.count', 1 do
            post articles_path, params: {article: {title: "test article from test", description: "test article description"}}
            follow_redirect!
        end
        assert_template 'articles/show'
        assert_match "test article from test", response.body
    end
    
end