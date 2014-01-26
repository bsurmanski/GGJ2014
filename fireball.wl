import "sprite.wl"
import "cstdlib.wl"
import "cstdio.wl"
import "sdl.wl"
import "list.wl"
import "main.wl"
import "particle.wl"
import "halo.wl"

Sprite^ fireballSprite = null

Particle^ fireball_new(float x, float y)
{
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

    float r = rand()
    r = r / float: RAND_MAX

    if(r < 0.1)
    {
        frag_new(fb.x, fb.y) 
    }

    return (fb.y > 300.0 ||
        fb.y < 0.0 - 50.0 ||
        fb.x < 0.0 - 50.0 ||
        fb.x > 350.0)
}

void fireball_draw(Particle^ fb, SDL_Surface^ dst, SDL_Surface^ lit)
{
    fireballSprite.x = fb.x
    fireballSprite.y = fb.y
    sprite_draw(dst, fireballSprite)

    halo_draw(lit, 4, fb.x, fb.y)
}
