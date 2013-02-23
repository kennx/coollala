# encoding: utf-8
require './spec/spec_helper'

describe "User Model" do
  context "User Model for Validation" do
    before(:each) do
      @user1 = User.new(:name => "kennx", :email => "kennx@test.com", :password => "1234567",
                        :password_confirmation => "1234567")
      @user2 = User.new(:name => "kennx2", :email => "kennx@qq.c", :password => "1234567",
                        :password_confirmation => "1234567")
      @user3 = User.new(:name => "kennx", :email => "kennx@test.com", :password => "1234",
                        :password_confirmation => "1234")
      @user4 = User.new(:name => "kennx", :email => "kennx@test.com", :password => "1234567",
               :password_confirmation => "")
      @user5 = User.new(:name => "kennx", :email => "kennx@test.com", :password => "12345671312312321312321321828377213872121313",
                        :password_confirmation => "12345671312312321312321321828377213872121313")
      @user6 = User.new(:name => "do", :email => "kennx@test.com", :password => "12345671312312321312321321828377213872121313",
                        :password_confirmation => "12345671312312321312321321828377213872121313")
      @new_user1 = User.new(:name => @user1.name, :email => "kennx2@test.com", :password => "1234567",
                           :password_confirmation => "1234567")
      @new_user2 = User.new(:name => "kennx231", :email => @user1.email, :password => "1234567",
                            :password_confirmation => "1234567")

    end
    it "should validation passing" do
      @user1.valid?.should be_true
    end
    it "should not validation passing for email an error" do
      @user2.valid?.should_not be_true
      @user2.errors.get(:email).should eq(["邮箱地址格式有误，请检查"])
    end
    it "should not validation passing for password is wrong" do
      @user3.valid?.should_not be_true
      @user3.errors.get(:password).should eq(["密码长度必须为大于5位小于等于20位"])
    end
    it "should not validation passing for password confirmation is blank" do
      @user4.valid?.should_not be_true
      @user4.errors.get(:password).should eq(["二次密码输入不一致"])
    end
    it "should not validation passing for password too long" do
      @user5.valid?.should_not be_true
      @user5.errors.get(:password).should eq(["密码长度必须为大于5位小于等于20位"])
    end
    it "should not validation passing for user name already exists" do
      @user1.save.should be_true
      @new_user1.valid?.should_not be_true
      @new_user1.errors.get(:name).should eq(["该用户名已存在，请使用其他用户名"])
      @user1.destroy.should be_valid
    end
    it "should destroy user for kennx" do
      @user1.save.should be_true
      User.find_by_name(@user1.name).destroy.should be_true
      User.where(:name => "kennx").blank?.should be_true
    end
    it "should not validation passing for user email already exists" do
      @user1.save.should be_true
      @new_user2.valid?.should_not be_true
      @new_user2.errors.get(:email).should eq(["该邮箱地址已被注册，请使用其他邮箱"])
      @user1.destroy.should be_valid
    end
    it "should authentication success for kennx(@user1)" do
      @user1.save.should be_true
      User.authentication("kennx", "1234567").should be_true
      @user1.destroy.should be_valid
    end
    it "should authentication fail for kennx2" do
      User.authentication("kennx2", "1234567").should be_nil
    end
  end
end