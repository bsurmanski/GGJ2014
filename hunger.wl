use "importc"

import(C) "/usr/include/SDL/SDL.h"
import(C) "/usr/include/stdlib.h"

import "list.wl"
import "sprite.wl"

Sprite^^ hungers = null
Sprite^ hunger0b = null
Sprite^ hungerMask = null

bool ishungerb = false
uint hungerTimer = 20
void hunger_init()
{
    hungers = malloc(8 * 10)
    hungers[0] = sprite_new("res/hunger0.png")
    hunger0b = sprite_new("res/hunger0b.png")
    hungers[1] = sprite_new("res/hunger1.png")
    hungers[2] = sprite_new("res/hunger2.png")
    hungers[3] = sprite_new("res/hunger3.png")
    hungers[4] = sprite_new("res/hunger4.png")
    hungers[5] = sprite_new("res/hunger5.png")
    hungers[6] = sprite_new("res/hunger6.png")
    hungers[7] = sprite_new("res/hunger7.png")
    hungers[8] = sprite_new("res/hunger8.png")
    hungers[9] = sprite_new("res/hunger9.png")

    hungerMask = sprite_new("res/hungermask.png")
}

void hunger_draw(SDL_Surface^ sf, SDL_Surface^ lt, int lvl)
{
    Sprite^ toDraw = null
    if(lvl == 0)
    {
        hungerTimer--    
        if(!hungerTimer)
        {
            hungerTimer = 20    
            if(ishungerb) ishungerb = false
            else ishungerb = true
        }
        if(ishungerb) toDraw = hunger0b
        else toDraw = hungers[0]
    } else
    {
        toDraw = hungers[lvl]    
    }

    toDraw.y = 16
    hungerMask.y = 16

    sprite_drawNormal(sf, toDraw) 
    sprite_drawNormal(lt, hungerMask) 
}
