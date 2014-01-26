
import "halo.wl"
import "main.wl"
import "cstdlib.wl"
import "cstdio.wl"
import "sdl.wl"
import "list.wl"

struct Particle
{
    float x
    float y
    float vx
    float vy
    uint timeout
}

List^ frag_list = null

Particle^ particle_new(float x, float y, float vx, float vy)
{
    Particle^ p = malloc(32)
    p.x = x
    p.y = y
    p.vx = vx
    p.vy = vy
    float r = rand()
    r = r / float: RAND_MAX
    p.timeout = 150 * r
    return p
}

void particle_init()
{
    if(frag_list == null)
    {
        frag_list = list_new()    
    }
}

void frag_new(float x, float y)
{
    float rx = rand()
    float ry = rand()
    rx = ((rx / float: RAND_MAX) * 1.0) - 0.5
    ry = 0.0 - (ry / float: RAND_MAX) * 1.0 - 0.5
    Particle ^p = particle_new(x, y, rx, ry)    
    list_add(frag_list, p)
}

void frag_update()
{
    list_begin(frag_list)
    while(!list_end(frag_list))
    {
        Particle^ p = list_get(frag_list)
        p.x = p.x + p.vx
        p.y = p.y + p.vy
        p.timeout-- 
        if(p.timeout == 0) list_remove(frag_list)
        list_next(frag_list)
    }
}

void frag_draw(SDL_Surface ^su, SDL_Surface^ lit)
{
    list_begin(frag_list)
    while(!list_end(frag_list))
    {
        Particle^ p = list_get(frag_list)
        uint cval = 128 + (128 << 8) + (200 << 16) + (150 << 24)
        setPixel(su, p.x, p.y, cval)

        //light
        //setPixel(lit, p.x, p.y, lval)
        halo_draw(lit, 1, p.x, p.y)

        list_next(frag_list)
    }
}
