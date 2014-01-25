import "sprite.wl"
import "cstdlib.wl"
import "cstdio.wl"
import "sdl.wl"
import "list.wl"
import "main.wl"
import "particle.wl"

Sprite^ fireballSprite = null
Sprite^ fireballLight = null

Particle^ fireball_new(float x, float y)
{
    if(fireballLight == null)
    {
        fireballLight = sprite_new("res/halo48.png")    
    }

    if(fireballSprite == null)
    {
        fireballSprite = sprite_new("res/fireball.png")
    }

    Particle^ fb = particle_new(x, y, 0, 10)
    return fb
}

bool fireball_update(Particle^ fb)
{
    fb.y = fb.y - 5.0

    float r = rand() / float: RAND_MAX

    //if(r < 0.5)
    //{
        //frag_new(fb.x, fb.y) 
    //}

    return (fb.y > 240.0 ||
        fb.y < 0.0 ||
        fb.x < 0.0 ||
        fb.x > 320.0)
}

void fireball_light(Particle^ fb, SDL_Surface^ dst)
{
    fireballLight.x = fb.x - fireballLight.img.w / 2
    fireballLight.y = fb.y - fireballLight.img.h / 2
    sprite_draw(dst, fireballLight)    
}

void fireball_draw(Particle^ fb, SDL_Surface^ dst)
{
    fireballSprite.x = fb.x
    fireballSprite.y = fb.y
    sprite_draw(dst, fireballSprite)
}
