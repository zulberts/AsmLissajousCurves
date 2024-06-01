#include <iostream>
extern "C" float calculate_x(float width, float a, float t);

int main()
{
    float width = 800.0; // Przykładowa wartość z zakresu 0-1
    float a = 2.0;
    float t = 0.02;
    float result;

    // Oblicz sinus
    result = calculate_x(width, a, t);

    // Wypisz wynik
    std::cout << "width " << width <<  " t " << t << " a " << a << " result " << result <<std::endl;

    return 0;
}
