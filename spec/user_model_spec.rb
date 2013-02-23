# encoding: utf-8
require 'spec_helper'

describe "User Model" do
  it "should create a user" do
    @user = User.new(:name => "kenn", :password => "123456",
                     :password_confirmation => "123456",
                     :email => "kennx@gmail.com")
    @user.valid?.should be_true
    @user.save.should be_true
    @user.destroy.should be_valid
  end
  it "should user authenticate passing"do
    @user = User.new(:name => "kenn", :password => "123456",:password_confirmation => "123456", :email => "kennx@gmail.com")
    @user.valid?.should be_true
    @user.save.should be_true
    User.authenticated("kenn", "123456").should eq(@user)
    @user.destroy.should be_valid
  end
  it "should create user fail，because password is different" do
    @user = User.new(:name => "kenn", :password => "123456",
                     :password_confirmation => "1234567",
                     :email => "kennx@gmail.com")
    @user.valid?.should be_false
    @user.errors.include?(:password).should be_true
  end
  it "should create user fail，because password is too short" do
    @user = User.new(:name => "kenn", :password => "123",
                     :password_confirmation => "123",
                     :email => "kennx@gmail.com")
    @user.valid?.should be_false
    @user.errors.include?(:password).should be_true
  end
end