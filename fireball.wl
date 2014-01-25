import "sprite.wl"
import "cstdlib.wl"
import "cstdio.wl"
import "sdl.wl"

struct Fireball
{
    Sprite ^sprite    
    float x
    float y
}

Fireball^ fireball_new(float x, float y)
{
    Fireball^ fb = malloc(32) 
    fb.sprite = sprite_new("res/fireball.png")
    fb.x = x
    fb.y = y
    return fb
}

void fireball_update(Fireball^ fb)
{
    fb.y = fb.y - 5.0
}

void fireball_draw(Fireball^ fb, SDL_Surface^ dst)
{
    fb.sprite.x = fb.x
    fb.sprite.y = fb.y
    sprite_draw(dst, fb.sprite)
}
