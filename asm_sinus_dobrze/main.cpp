#include <iostream>
extern "C" float calculate_sin(float value);

int main()
{
    float input = 3.14; // Przykładowa wartość z zakresu 0-1
    float result;

    // Oblicz sinus
    result = calculate_sin(input);

    // Wypisz wynik
    std::cout << "Sinus " << input << " = " << result << std::endl;

    return 0;
}
