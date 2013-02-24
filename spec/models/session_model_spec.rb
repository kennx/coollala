require './spec/spec_helper'

describe "Session Model" do
  it "should user login success" do
    session = Session.new(:username => "kennx", :password => "1234567")
    session.valid?.should be_true
  end
  it "should user login fail" do
    session = Session.new(:username => "kennx")
    session.valid?.should_not be_true
  end
end