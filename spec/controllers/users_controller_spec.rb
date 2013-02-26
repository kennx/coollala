# encoding: utf-8
require './spec/spec_helper'



describe "login", :type => :request do
  it "should be sign_in page respond to " do
    visit '/sign_in'
    page.should have_field("session[password]")
    page.should have_field("session[username]")
    page.should have_button("提交")
  end
  it "should signed in" do
    page.driver.follow :put, "/sign_in", Session.new(:password => "123456", :username => "kenn")
    page.driver.status_code.should == 303
  end
end