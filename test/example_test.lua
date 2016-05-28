require "lunit"

module( "my_testcase", lunit.testcase )

function test_success()
  assert_false( false, "This test never fails.")
end
