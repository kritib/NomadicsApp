require 'spec_helper'

describe "travels/show" do
  before(:each) do
    @travel = assign(:travel, stub_model(Travel,
      :from => "From",
      :to => "To",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/From/)
    rendered.should match(/To/)
    rendered.should match(/1/)
  end
end
