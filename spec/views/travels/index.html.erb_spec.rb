require 'spec_helper'

describe "travels/index" do
  before(:each) do
    assign(:travels, [
      stub_model(Travel,
        :from => "From",
        :to => "To",
        :user_id => 1
      ),
      stub_model(Travel,
        :from => "From",
        :to => "To",
        :user_id => 1
      )
    ])
  end

  it "renders a list of travels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "From".to_s, :count => 2
    assert_select "tr>td", :text => "To".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
