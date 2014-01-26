import "particle.wl"
import "list.wl"
import "sdl.wl"
import "sprite.wl"
import "cstdlib.wl"
import "halo.wl"

List^ mice = null
Sprite^ mouseSprite = null
Sprite^ mouseFire1 = null
Sprite^ mouseFire2 = null

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
    mouseFire1 = sprite_new("res/mousefire1.png")
    mouseFire2 = sprite_new("res/mousefire2.png")
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
        m.vx = ((rand() / float: RAND_MAX) * 2.0)
        m.vy = ((rand() / float: RAND_MAX) * 2.0) - 0.5
    }

    m.timer = m.timer - 1
}

void mouse_enflame(Mouse^ m)
{
    m.flaming = true    
}

void mouse_draw(Mouse^ m, SDL_Surface^ sf)
{
    if(m.flaming){
        if((m.timer / 10) % 2 == 0)
        {
            mouseFire1.x = m.x
            mouseFire1.y = m.y
            sprite_draw(sf, mouseFire1)    
        } else
        {
            mouseFire2.x = m.x
            mouseFire2.y = m.y
            sprite_draw(sf, mouseFire2)    
        }
    }
    else{
        mouseSprite.x = m.x
        mouseSprite.y = m.y
        sprite_draw(sf, mouseSprite)    
    }
}

void mouse_light(Mouse^ m, SDL_Surface^ sf)
{
    if(m.flaming)
    {
        halo_draw(sf, 4, m.x, m.y) 
    }
}

void mice_update()
{
    list_begin(mice)
    while(!list_end(mice))
    {
        Mouse^ m = list_get(mice)
        mouse_update(m)

        if(m.y > 300) list_remove(mice)
        list_next(mice)    
    }
}

void mice_light(SDL_Surface^ sf)
{
    list_begin(mice)
    while(!list_end(mice))
    {
        mouse_light(list_get(mice), sf)    
        list_next(mice)
    }
}

void mice_draw(SDL_Surface^ sf, SDL_Surface^ lit)
{
    list_begin(mice)
    while(!list_end(mice))
    {
        Mouse^ m = list_get(mice)
        mouse_draw(m, sf)
        mouse_light(m, lit)
        list_next(mice)
    }
}
