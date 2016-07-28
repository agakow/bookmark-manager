
def sign_up
  visit '/users/new'
  fill_in :email, with: 'a'
  fill_in :password, with: 'b'
  click_button 'Submit'
end
