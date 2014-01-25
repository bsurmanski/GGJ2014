import "sprite.wl"
import "cstdlib.wl"
import "sdl.wl"
import "fireball.wl"

struct Owl
{
    float x
    float y
    Sprite^ head
    Sprite^ body
    Sprite^ wingl
    Sprite^ wingr
    Sprite^ tail
    Sprite^ halo
}

int HEADX = 8 
int HEADY = 10 
int TAILX = 8 
int TAILY = 30
int BODYX = 16
int BODYY = 0
int WINGX = 20
int WINGY = 8

int HALOX = 32
int HALOY = 16

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
    o.halo = sprite_new("res/halo256.png")
    
    return o
}

void owl_update(Owl^ o)
{
    o.head.x = o.x - HEADX    
    o.head.y = o.y - HEADY
    o.tail.x = o.x - TAILX
    o.tail.y = o.y + TAILY
    o.body.x = o.x - BODYX
    o.body.y = o.y + BODYY
    o.wingl.x = o.x - WINGX - 16.0
    o.wingl.y = o.y + WINGY
    o.wingr.x = o.x + WINGX - 16.0
    o.wingr.y = o.y + WINGY

    o.halo.x = o.x - o.halo.img.w / 2
    o.halo.y = o.y - o.halo.img.h / 2
}

void owl_light(Owl^ o, SDL_Surface^ dst)
{
    sprite_draw(dst, o.halo)    
}

void owl_draw(Owl^ o, SDL_Surface^ dst)
{
    sprite_draw(dst, o.body) 
    sprite_draw(dst, o.head) 
    sprite_draw(dst, o.wingl) 
    sprite_draw(dst, o.wingr) 
    sprite_draw(dst, o.tail) 
}
