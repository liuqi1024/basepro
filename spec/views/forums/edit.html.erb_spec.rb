require 'spec_helper'

describe "forums/edit" do
  before(:each) do
    @forum = assign(:forum, stub_model(Forum,
      :title => "MyString",
      :desc => "MyString",
      :cover => nil
    ))
  end

  it "renders the edit forum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forums_path(@forum), :method => "post" do
      assert_select "input#forum_title", :name => "forum[title]"
      assert_select "input#forum_desc", :name => "forum[desc]"
      assert_select "input#forum_cover", :name => "forum[cover]"
    end
  end
end
