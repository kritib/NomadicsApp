require 'spec_helper'

describe "travels/edit" do
  before(:each) do
    @travel = assign(:travel, stub_model(Travel,
      :from => "MyString",
      :to => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit travel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => travels_path(@travel), :method => "post" do
      assert_select "input#travel_from", :name => "travel[from]"
      assert_select "input#travel_to", :name => "travel[to]"
      assert_select "input#travel_user_id", :name => "travel[user_id]"
    end
  end
end
