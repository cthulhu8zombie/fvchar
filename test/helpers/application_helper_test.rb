require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, 'Fragrant Vagrant\'s Character Port.fol.io'
    assert_equal full_title("Help"), 'Help | Fragrant Vagrant\'s Character Port.fol.io'
    assert_equal full_title("About"), 'About | Fragrant Vagrant\'s Character Port.fol.io'
    assert_equal full_title("Contact"), 'Contact | Fragrant Vagrant\'s Character Port.fol.io'
  end
end