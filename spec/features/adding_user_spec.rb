

feature 'add user'  do
  scenario 'so a user can sign up' do
    expect{sign_up}.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'require a matching confirmation password' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
  end

  scenario 'with a password that does not match' do
    sign_up password_confirmation: '54321'
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'user can\'t sign up without email' do
    expect{sign_up email: nil}.not_to change User, :count
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'can\'t sign in with invalid email' do
    expect{sign_up email: 'alice@example'}.not_to change User, :count
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Email has invalid format'
  end

  scenario 'can\'t sign up with a registered email' do
    sign_up email: 'alice@example.com'
    expect{sign_up email: 'alice@example.com'}.not_to change User, :count
    expect(page).to have_content('Email is already taken')
  end

end
