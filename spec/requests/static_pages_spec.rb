require 'spec_helper'

describe "StaticPages" do
  
  let(:base_title) { "Whispering Words" }
  
  describe "Home page" do
    before{visit root_path}
    it "should have the header 'Whispering Words'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
        page.should have_selector('h1',:text => 'Whispering Words')
    end
    it "should have the right title" do
      page.should have_selector('title', :text => "#{base_title}")
    end
    it "should not have a custom page title" do
      page.should_not have_selector('title', :text => '| Home')
    end
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end#end of for signed-in users
  end#end of home page
  
  describe "Help Page" do
    before{visit help_path}
    it "should have the header 'Help'" do
      page.should have_selector('h1',:text => 'Help')
    end
    it "should have the right title" do 
      page.should have_selector('title', :text => "#{base_title} | Help")
    end
  end
  
   describe "About Page" do
     before{visit about_path}
    it "should have the header 'About Us'" do
      page.should have_selector('h1',:text => 'About Us')
    end
    it "should have the right title" do
      page.should have_selector('title', :text => "#{base_title} | About Us")
    end
  end
  
  describe "Contact Page" do
    before{visit contact_path}
    it "should have the h1 'Contact'" do
      page.should have_selector('h1', text: 'Contact')
    end

    it "should have the title 'Contact'" do
      page.should have_selector('title', :text => "#{base_title} | Contact")
    end
  end
  
end
