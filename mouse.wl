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
    float vx
    float vy
    int timer
    bool flaming
    bool dead
}

void mice_init()
{
    mice = list_new()
    mouseSprite = sprite_new("res/mouse.png")
    list_add(mice, mouse_new())
    list_add(mice, mouse_new())
    list_add(mice, mouse_new())
    list_add(mice, mouse_new())
}

Mouse^ mouse_new()
{
    Mouse^ m = malloc(32)
    m.x = 40
    m.y = 40
    m.vx = 0
    m.vy = 0
    m.timer = 0
    m.flaming = false
    m.dead = false
    return m
}

void mouse_update(Mouse^ m)
{
    m.y = m.y + 1 

    m.x = m.x + m.vx
    m.y = m.y + m.vy

    if(m.timer == 0)
    {
        m.timer = 100    
        m.vx = ((rand() / float: RAND_MAX) / 4.0) - 0.125
        m.vy = ((rand() / float: RAND_MAX) / 4.0) - 0.125
    }

    m.timer = m.timer - 1
}

void mouse_draw(Mouse^ m, SDL_Surface^ sf)
{
    mouseSprite.x = m.x
    mouseSprite.y = m.y
    sprite_draw(sf, mouseSprite)    
}

void mice_update()
{
    list_begin(mice)
    while(!list_end(mice))
    {
        Mouse^ m = list_get(mice)
        mouse_update(m)

        if(m.y > 240) list_remove(mice)
        list_next(mice)    
    }
}

void mice_draw(SDL_Surface^ sf)
{
    list_begin(mice)
    while(!list_end(mice))
    {
        mouse_draw(list_get(mice), sf)    
        list_next(mice)
    }
}
