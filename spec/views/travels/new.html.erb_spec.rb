require 'spec_helper'

describe "travels/new" do
  before(:each) do
    assign(:travel, stub_model(Travel,
      :from => "MyString",
      :to => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new travel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => travels_path, :method => "post" do
      assert_select "input#travel_from", :name => "travel[from]"
      assert_select "input#travel_to", :name => "travel[to]"
      assert_select "input#travel_user_id", :name => "travel[user_id]"
    end
  end
end
