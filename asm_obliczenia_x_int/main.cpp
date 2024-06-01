#include <iostream>
extern "C" int calculate_x(int width, float a, float t);

int main()
{
    int width = 800; // Przykładowa wartość dla SCREEN_WIDTH
    float a = 2.0;
    float t = 0.5;
    int result;

    // Oblicz wartość x
    result = calculate_x(width, a, t);

    // Wypisz wynik
    std::cout << "width: " << width << " t: " << t << " a: " << a << " result: " << result << std::endl;

    return 0;
}
