require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :first => "MyString",
      :last => "MyString",
      :email => "MyString",
      :photo_blob => "",
      :password_digest => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_first", :name => "user[first]"
      assert_select "input#user_last", :name => "user[last]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_photo_blob", :name => "user[photo_blob]"
      assert_select "input#user_password_digest", :name => "user[password_digest]"
    end
  end
end
