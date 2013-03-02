# encoding: utf-8
require './spec/spec_helper'



describe "session", :type => :request do
  it "should sign in for successful." do
    visit '/sign_in'
    fill_in "session[username]", :with => "kenn"
    fill_in "session[password]", :with => "123456"
    click_button "登录"
    current_path.should == '/'
  end
  it "should return status code: 401" do
    visit '/admin/groups'
    page.driver.status_code.should == 401
  end
  it "should return status code: 200" do
    visit '/sign_in'
    fill_in "session[username]", :with => "kenn"
    fill_in "session[password]", :with => "123456"
    click_button "登录"
    page.visit '/admin/users'
    page.driver.status_code.should == 200
  end
  it "should sign up for successful" do
    visit '/sign_up'
    fill_in 'user[name]', :with => "kennx2"
    fill_in 'user[email]', :with => "kennx2@test.com"
    fill_in 'user[password]', :with => "123456"
    fill_in 'user[password_confirmation]', :with => "123456"
    click_button "注册"
    current_path.should == '/sign_in'
  end
end