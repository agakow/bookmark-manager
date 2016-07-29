
def sign_up(email: 'alice@example.com',
            password: '12345',
            password_confirmation: '12345')
  visit '/users/new'
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Submit'
end
