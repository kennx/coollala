# encoding: utf-8
require './spec/spec_helper'

describe "Group" do
  it "should create an group" do
    visit '/sign_in'
    fill_in 'session[username]', :with => "kenn"
    fill_in 'session[password]', :with => "123456"
    click_button "登录"
    page.visit '/group/new'
    fill_in 'group[name]',    :with => "test"
    fill_in 'group[slug]',    :with => "testslug"
    fill_in 'group[summary]', :with => "......."
    click_button "申请小组"
    current_path.should == '/groups'
  end
end