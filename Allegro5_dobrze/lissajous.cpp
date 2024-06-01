#include <allegro5/allegro.h>
#include <allegro5/allegro_primitives.h>
#include <allegro5/allegro_font.h>
#include <cmath>
#include <iostream>

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 600;

int a = 1; // Parametr a
int b = 1; // Parametr b

void draw_lissajous_curve(ALLEGRO_FONT *font, int a, int b)
{
    al_clear_to_color(al_map_rgb(0, 0, 0));

    for (float t = 0; t < 2 * ALLEGRO_PI; t += 0.0001)
    {
        float x = SCREEN_WIDTH / 2 + (SCREEN_WIDTH / 2) * sin(a * t);
        float y = SCREEN_HEIGHT / 2 + (SCREEN_HEIGHT / 2) * sin(b * t);
        al_draw_pixel(x, y, al_map_rgb(255, 0, 0));
    }

    al_draw_textf(font, al_map_rgb(255, 255, 255), 10, SCREEN_HEIGHT - 30, 0, "a: %d, b: %d", a, b);
    al_flip_display();
}

int main()
{
    if (!al_init())
    {
        std::cerr << "Failed to initialize Allegro." << std::endl;
        return -1;
    }

    if (!al_init_primitives_addon())
    {
        std::cerr << "Failed to initialize primitives addon." << std::endl;
        return -1;
    }

    if (!al_init_font_addon())
    {
        std::cerr << "Failed to initialize font addon." << std::endl;
        return -1;
    }

    ALLEGRO_DISPLAY *display = al_create_display(SCREEN_WIDTH, SCREEN_HEIGHT);
    if (!display)
    {
        std::cerr << "Failed to create display." << std::endl;
        return -1;
    }

    al_install_keyboard();

    ALLEGRO_EVENT_QUEUE *event_queue = al_create_event_queue();
    al_register_event_source(event_queue, al_get_display_event_source(display));
    al_register_event_source(event_queue, al_get_keyboard_event_source());

    ALLEGRO_FONT *font = al_create_builtin_font();
    if (!font)
    {
        std::cerr << "Failed to create font." << std::endl;
        al_destroy_display(display);
        al_destroy_event_queue(event_queue);
        return -1;
    }

    draw_lissajous_curve(font, a, b);

    bool running = true;
    while (running)
    {
        ALLEGRO_EVENT ev;
        al_wait_for_event(event_queue, &ev);

        if (ev.type == ALLEGRO_EVENT_DISPLAY_CLOSE)
        {
            running = false;
        }
        else if (ev.type == ALLEGRO_EVENT_KEY_DOWN)
        {
            switch (ev.keyboard.keycode)
            {
            case ALLEGRO_KEY_W:
                a++;
                break;
            case ALLEGRO_KEY_S:
                if (a > 1)
                    a--;
                break;
            case ALLEGRO_KEY_D:
                b++;
                break;
            case ALLEGRO_KEY_A:
                if (b > 1)
                    b--;
                break;
            }
            draw_lissajous_curve(font, a, b);
        }
    }

    al_destroy_font(font);
    al_destroy_display(display);
    al_destroy_event_queue(event_queue);
    al_shutdown_primitives_addon();

    return 0;
}
