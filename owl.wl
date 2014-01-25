import "sprite.wl"
import "cstdlib.wl"
import "sdl.wl"

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

int HEADX = 10
int HEADY = 10
int TAILX = 8 
int TAILY = 30

Owl^ owl_new()
{
    Owl^ o = malloc(128)
    o.x = 0
    o.y = 0
    o.head = sprite_new("res/owlhead.png") 
    o.body = sprite_new("res/owlbody.png") 
    o.wingl = sprite_new("res/owlwing.png") 
    o.wingr = sprite_new("res/owlwing.png") 
    o.tail = sprite_new("res/owltail.png")
    
    return o
}

void owl_update(Owl^ o)
{
    o.head.x = o.x - HEADX    
    o.head.y = o.y + HEADY
    o.tail.x = o.x + TAILX
    o.tail.y = o.y + TAILY
}

void owl_draw(Owl^ o, SDL_Surface^ dst)
{
    sprite_draw(dst, o.body) 
    sprite_draw(dst, o.head) 
    //sprite_draw(dst, o.wingl) 
    sprite_draw(dst, o.tail) 
}
