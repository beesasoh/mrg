require 'spec_helper'

describe RankingsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'today'" do
    it "returns http success" do
      get 'today'
      response.should be_success
    end
  end

  describe "GET 'week'" do
    it "returns http success" do
      get 'week'
      response.should be_success
    end
  end

end
