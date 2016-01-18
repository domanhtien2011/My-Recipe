require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: 'Yasuo', email: 'yasuo@gmail.com')
  end

  test "Chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = 'a' * 41
    assert_not @chef.valid?
  end

  test "chefname should not be too short" do
    @chef.chefname = 'a' * 2
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end

  test "email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eeem.au laura+joe@monk.cn]
    valid_addresses.each do |f|
      @chef.email = f
      assert @chef.valid?, "#{f.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@eee,com user_at_eee.org user.name@example.com. eee@sadasd_aa.com foo@eee+asdasd.com]
    invalid_addresses.each do |f|
      @chef.email = f
      assert_not @chef.valid?, "#{f.inspect} should be invalid"
    end
  end
end
