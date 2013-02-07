require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "Kriti", 
  													last_name: "Bajaj", 
  													email: "kritib@gmail.com",
  													password: "blahblah4",
  													password_confirmation: "blahblah4") }
  before { @user.refresh_token }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:travelers) }
  it { should respond_to(:friends) }
  it { should respond_to(:session_token) }

  it "must have a username" do
    bad_user = User.new
    bad_user.should_not be_valid
  end


end