import "sdl.wl"
import "sprite.wl"

Sprite^ bg = null

void background_init()
{
    bg = sprite_new("res/bg.png") 
    bg.y = 0.0 - 240.0
}

void background_update()
{
    bg.y = bg.y + 1    
    if(bg.y >= 0.0)
        bg.y = bg.y - 240.0
}

void background_draw(SDL_Surface^ dst)
{
    sprite_drawNormal(dst, bg)
}
