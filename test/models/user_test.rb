require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user_name = 'Fragrant Vagrant'
    @user_email = 'fragrant.vagrant@fv.org'
    @user = User.new(name: @user_name, email: @user_email)
  end
  
  test 'should be valid' do
    assert @user.valid?
  end
  
  test 'name should be present' do
    @user.name = "        "
    assert_not @user.valid?
  end
  
  test 'email should be present' do
    @user.email = "        "
    assert_not @user.valid?
  end
  
  test 'name should not be too long' do
    # repeat a 51 times to make it too long
    @user.name = 'a' * 51
    assert_not @user.valid?
  end
  
  test 'email should not be too long' do
    # repeat a 256 times to make it too long
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end
  
  test 'email validation should accept valid addresses' do
    # create an array of strings using %w
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    # for each address in the array
    valid_addresses.each do |valid_address|
      # set our email to the address to check
      @user.email = valid_address
      # assert that with this email our user is still valid or throw informative message
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    # create an array of strings using %w
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    # for each address in the array
    invalid_addresses.each do |invalid_address|
      # set our email to the address to check
      @user.email = invalid_address
      # assert that with this email our user is not valid or throw informative message
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end