require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :first => "First",
      :last => "Last",
      :email => "Email",
      :photo_blob => "",
      :password_digest => "Password Digest"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First/)
    rendered.should match(/Last/)
    rendered.should match(/Email/)
    rendered.should match(//)
    rendered.should match(/Password Digest/)
  end
end
