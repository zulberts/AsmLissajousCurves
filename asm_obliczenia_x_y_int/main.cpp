#include <iostream>
extern "C" void calculate_x_y(int height, int width, float t, float a, float b, int *x, int *y);

int main()
{
    int height = 1080; // Przykładowa wartość dla SCREEN_HEIGHT
    int width = 1920;  // Przykładowa wartość dla SCREEN_WIDTH
    float t = 0.02;
    float a = 2.0;
    float b = 3.0;
    int x, y;

    // Oblicz wartości x i y
    calculate_x_y(height, width, t, a, b, &x, &y);

    // Wypisz wynik
    std::cout << "height: " << height << " width: " << width << " t: " << t << " a: " << a << " b: " << b << " x: " << x << " y: " << y << std::endl;

    return 0;
}
