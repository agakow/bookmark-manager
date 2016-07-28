

feature 'add user'  do
  scenario 'so a user can sign up' do
    expect{sign_up}.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, a')
    expect(User.first.email).to eq('a')
  end

end
