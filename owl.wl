import "sprite.wl"
import "cstdlib.wl"
import "sdl.wl"
import "fireball.wl"
import "halo.wl"
import "main.wl"

struct Owl
{
    float x
    float y
    Sprite^ head
    Sprite^ body
    Sprite^ wingl
    Sprite^ wingr
    Sprite^ tail
}

int HEADX = 0 
int HEADY = 20 
int TAILX = 0 
int TAILY = 20
int BODYX = 0
int BODYY = 0
int WINGX = 20
int WINGY = 0

int HALOX = 0
int HALOY = 0

Owl^ owl_new()
{
    Owl^ o = malloc(128)
    o.x = 160
    o.y = 200
    o.head = sprite_new("res/owlhead.png") 
    o.body = sprite_new("res/owlbody.png") 
    o.wingl = sprite_new("res/owlwingl.png") 
    o.wingr = sprite_new("res/owlwingr.png") 
    o.tail = sprite_new("res/owltail.png")
    return o
}

void owl_update(Owl^ o)
{
    o.head.x = o.x
    o.head.y = o.y - HEADY
    o.tail.x = o.x
    o.tail.y = o.y + TAILY
    o.body.x = o.x
    o.body.y = o.y
    o.wingl.x = o.x - WINGX
    o.wingl.y = o.y + WINGY
    o.wingr.x = o.x + WINGX
    o.wingr.y = o.y + WINGY
}

void owl_draw(Owl^ o, SDL_Surface^ dst, SDL_Surface^ lit)
{
    sprite_draw(dst, o.body) 
    sprite_draw(dst, o.head) 
    sprite_draw(dst, o.wingl) 
    sprite_draw(dst, o.wingr) 
    sprite_draw(dst, o.tail) 

    if(hunger >= 2000)
    {
        halo_draw(lit, 2, o.x, o.y)
    } else if(hunger >= 1800)
    {
        halo_draw(lit, 2, o.x, o.y)
    } else if(hunger >= 1600)
    {
        halo_draw(lit, 3, o.x, o.y)
    } else if(hunger >= 1400)
    {
        halo_draw(lit, 3, o.x, o.y)
    } else if(hunger >= 1200)
    {
        halo_draw(lit, 4, o.x, o.y)
    } else if(hunger >= 1000)
    {
        halo_draw(lit, 4, o.x, o.y)
    } else if(hunger >= 800)
    {
        halo_draw(lit, 5, o.x, o.y)
    } else if(hunger >= 600)
    {
        halo_draw(lit, 6, o.x, o.y)
    } else if(hunger >= 400)
    {
        halo_draw(lit, 7, o.x, o.y)    
    } else if(hunger >= 200)
    {
        halo_draw(lit, 8, o.x, o.y)    
    } else
    {
        halo_draw(lit, 9, o.x, o.y)    
    }
}
