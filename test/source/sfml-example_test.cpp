#include <catch2/catch.hpp>

#include "lib.hpp"

TEST_CASE("Name is sfml-example", "[library]")
{
  library lib;
  REQUIRE(lib.name == "sfml-example");
}
