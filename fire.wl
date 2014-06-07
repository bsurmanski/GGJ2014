use "importc"

import(C) "/usr/include/SDL/SDL.h"
import(C) "/usr/include/stdio.h"
import(C) "/usr/include/stdlib.h"

import "sprite.wl"
import "list.wl"
import "halo.wl"

Sprite^^ fire = null

void fire_init()
{
    fire = malloc(8 * 10)    
    fire[0] = sprite_new("res/fire16_1.png")
    fire[1] = sprite_new("res/fire16_2.png")
    fire[2] = sprite_new("res/fire32_1.png")
    fire[3] = sprite_new("res/fire32_2.png")
}

void fire_draw(SDL_Surface^ sf, SDL_Surface^ lit, int n, float x, float y)
{
    fire[n].x = x
    fire[n].y = y

    sprite_draw(sf, fire[n])

    if(n == 0 || n == 1)
    {
        halo_draw(lit, 6, x, y)    
    } else if(n == 2 || n == 3)
    {
        halo_draw(lit, 9, x, y)    
    }
}
