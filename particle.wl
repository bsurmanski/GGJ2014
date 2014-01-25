
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
}

List^ frag_list = null

Particle^ particle_new(float x, float y, float vx, float vy)
{
    Particle^ p = malloc(16)
    p.x = x
    p.y = y
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
    Particle ^p = particle_new(x, y, 1.0, 1.0)    
    list_add(frag_list, p)
}

void frag_light(SDL_Surface ^su)
{
    list_begin(frag_list)
    while(!list_end(frag_list))
    {
        Particle^ p = list_get(frag_list)
        uint val = 255 + (255 << 8) + (255 << 16) + (255 << 24)
        setPixel(su, p.x, p.y, val)
        list_next(frag_list)
    }
}

void frag_update()
{
    list_begin(frag_list)
    while(!list_end(frag_list))
    {
        Particle^ p = list_get(frag_list)
        p.x = p.x + p.vx
        p.y = p.y + p.vy
        if(p.x > 320 || p.x < 0 || p.y > 240 || p.y < 0) list_remove(frag_list)
        list_next(frag_list)
    }
}

void frag_draw(SDL_Surface ^su)
{
    list_begin(frag_list)
    while(!list_end(frag_list))
    {
        Particle^ p = list_get(frag_list)
        p.x = 5
        setPixel(su, p.x, p.y, 1000)
        list_next(frag_list)
    }
}
