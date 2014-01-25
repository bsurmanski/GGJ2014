import "particle.wl"
import "list.wl"
import "sdl.wl"
import "sprite.wl"
import "cstdlib.wl"

List^ mice = null
Sprite^ mouseSprite = null

struct Mouse
{
    float x
    float y
}

void mice_init()
{
    mice = list_new()
    mouseSprite = sprite_new("res/mouse.png")
}

void mouse_update(Mouse^ m)
{
    
}

void mice_update()
{
    while(!list_end(mice))
    {
        mouse_update(list_get(mice))
        list_next(mice)    
    }
}
