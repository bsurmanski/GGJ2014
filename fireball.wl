import "sprite.wl"
import "cstdlib.wl"
import "cstdio.wl"
import "sdl.wl"
import "list.wl"
import "main.wl"

Sprite^ fireballSprite = null
Sprite^ fireballLight = null
struct Fireball
{
    float x
    float y
}

Fireball^ fireball_new(float x, float y)
{
    if(fireballLight == null)
    {
        fireballLight = sprite_new("res/fbhalo.png")    
    }

    if(fireballSprite == null)
    {
        fireballSprite = sprite_new("res/fireball.png")
    }

    Fireball^ fb = malloc(16) 
    fb.x = x
    fb.y = y
    return fb
}

bool fireball_update(Fireball^ fb)
{
    fb.y = fb.y - 5.0
    return (fb.y > 240 ||
        fb.y < 0 ||
        fb.x < 0 ||
        fb.x > 320);
            
}

void fireball_light(Fireball^ fb, SDL_Surface^ dst)
{
    fireballLight.x = fb.x - 12
    fireballLight.y = fb.y - 12
    sprite_draw(dst, fireballLight)    
}

void fireball_draw(Fireball^ fb, SDL_Surface^ dst)
{
    fireballSprite.x = fb.x
    fireballSprite.y = fb.y
    sprite_draw(dst, fireballSprite)
}
