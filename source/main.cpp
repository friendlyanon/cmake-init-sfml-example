#include <iostream>
#include <string>

#include <SFML/Graphics.hpp>

#include "lib.hpp"

namespace
{
auto create_window() -> sf::RenderWindow
{
  auto const window_width = 350U;
  auto const window_height = 75U;
  return {sf::VideoMode(window_width, window_height), "SFML window"};
}

auto create_font() -> sf::Font
{
  auto font = sf::Font();
  if (!font.loadFromFile("assets/fonts/TruenoLight.otf")) {
    throw std::runtime_error("Couldn't load the Trueno font");
  }
  return font;
}

auto create_text(sf::Font const& font, library const& lib) -> sf::Text
{
  auto const sfml_string = sf::String(lib.name);
  auto const character_size = 50U;
  return {sfml_string, font, character_size};
}

auto try_main() -> void
{
  auto const font = create_font();
  auto const text = create_text(font, library());

  for (auto window = create_window(); window.isOpen();) {
    for (auto event = sf::Event(); window.pollEvent(event);) {
      if (event.type == sf::Event::Closed) {
        window.close();
      }
    }
    window.clear();
    window.draw(text);
    window.display();
  }
}

}  // namespace

auto main() -> int
{
  try {
    try_main();
  } catch (std::exception const& error) {
    std::cerr << error.what() << '\n';
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}
