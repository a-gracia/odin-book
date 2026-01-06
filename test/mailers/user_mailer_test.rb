require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "Welcome new user" do
    # Set user variable
    user = users(:one)

    # Create the email and store it for further assertions
    email = UserMailer.with(user: user).welcome_email

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal [ "notifications@example.com" ], email.from
    assert_equal [ "perro@mailinator.com" ], email.to
    assert_equal "Welcome to Odinbook", email.subject
  end
end
