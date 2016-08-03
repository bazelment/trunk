#include "gtest/gtest.h"

// A simple example to demonstrate the usage of gtest:
// https://github.com/google/googletest

namespace examples {
namespace {

class HelloTest : public testing::Test {
 protected:
  virtual void SetUp() override {
  }

  virtual void TearDown() override {
  }
};

TEST_F(HelloTest, Foo) {
  int a = 1;
  EXPECT_EQ(1, a);
}

}  // anonymous namespace
}  // namespace examples
