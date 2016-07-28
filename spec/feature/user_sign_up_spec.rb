require 'spec_helper'

  feature 'user sign up' do
    scenario 'user can sign up' do
      sign_up
      expect(page).to have_content('Welcome aga!')
    end

    scenario 'on user sign-in increase user count by one' do
      sign_up
      expect(User.count).to eq 1
    end

    scenario 'check user\'s email address is correct' do
      sign_up
      expect(User.first.email).to eq('aga@gmail.com')
    end

    scenario 'sign up fails if password does not match password confiramtion' do
      visit '/'
      click_button('Sign up')
      fill_in "name", :with => "aga"
      fill_in "email", :with => "aga@gmail.com"
      fill_in "password", :with => "monkey"
      fill_in "password_confirmation", :with => "wrong password"
      click_button "Sign me up!"
      expect(page).to have_content "Your passwords don't match"
    end

    scenario "user can't sign up without entering an email" do
      visit '/'
      click_button('Sign up')
      fill_in "name", :with => "aga"
      fill_in "password", :with => "monkey"
      fill_in "password_confirmation", :with => "monkey"
      click_button "Sign me up!"
      expect(page).to have_content "Please enter an email address"
    end

    scenario "user can't sign up without entering a valid email" do
      visit '/'
      click_button('Sign up')
      fill_in "name", :with => "aga"
      fill_in "password", :with => "monkey"
      fill_in "email", :with => "invalidemail"
      fill_in "password_confirmation", :with => "monkey"
      click_button "Sign me up!"
      expect(page).to have_content "Please enter a valid email address"
    end

  end
