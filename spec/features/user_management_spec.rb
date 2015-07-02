feature 'User sign up' do

  let(:user) do
    build(:user)
  end

  # Strictly speaking, the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB since these are separate concerns
  # and we should only test one concern at a time.

  # However, we are currently driving everything through
  # feature tests and we want to keep this example simple.

  scenario 'I can sign up as a new user' do
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, #{user.email}")
    expect(User.first.email).to eq("#{user.email}")
  end

  scenario 'requires a matching confirmation password' do
    # again it's questionable whether we should be testing the model at this
    # level.  We are mixing integration tests with feature tests.
    # However, it's convenient for our purposes.
    user = build(:user, password_confirmation: "wrong")
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'user must complete email field' do
      user = build(:user, email: " ")
      expect { sign_up(user) }.not_to change(User, :count)
      expect(current_path).to eq('/users')
      # expect(page).to have_content('please enter an email')
  end

  scenario 'I cannot sign up with an existing email' do
    sign_up(user)
    expect { sign_up(user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end

  # sign up helper method moved to factory user spec file
  # def sign_up(
  #             email: 'alice@example.com',
  #             password: '12345678',
  #             password_confirmation: '12345678')
  #   visit '/users/new'
  #   # expect(page.status_code).to eq(200)
  #   fill_in :email,    with: email
  #   fill_in :password, with: password
  #   fill_in :password_confirmation, with: password_confirmation
  #   click_button 'Sign up'
  # end

end

feature 'User log in' do

  let(:user) do
    create(:user)
  end

  scenario 'with correct credentials' do
    # sign_up(user)
    log_in(user)
    expect(page).to have_content "Welcome, #{user.email}"
  end

end

feature 'User signs out' do

  let(:user) do
    create(:user)
  end

  scenario 'while being signed in' do
    log_in(user)
    click_button 'Log out'
    expect(page).to have_content('goodbye!') # where does this message go?
    expect(page).not_to have_content("Welcome, #{user.email}")
  end

end
