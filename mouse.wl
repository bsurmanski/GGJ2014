import "particle.wl"
import "list.wl"
import "sdl.wl"
import "sprite.wl"
import "cstdlib.wl"
import "halo.wl"
import "fire.wl"

List^ mice = null
Sprite^ mouseSprite = null
Sprite^^ mouse = null

struct Mouse
{
    float x
    float y
    float vx
    float vy
    int timer
    int cook
    bool flaming
}

void mice_init()
{
    mice = list_new()
    mouse = malloc(8 * 10)
    mouse[0] = sprite_new("res/mouse.png")
    mouse[1] = sprite_new("res/mouseburnt.png")
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
    m.cook = 0
    return m
}

void mouse_update(Mouse^ m)
{
    m.y = m.y + 1 

    m.x = m.x + m.vx
    m.y = m.y + m.vy

    if(m.timer == 0)
    {
        if(m.flaming)
        {
            if(m.cook == 0) m.cook++ //TODO: update when more cooked mice avail
            m.timer = 50
            m.vx = 0
            m.vy = 0
        } else
        {
            m.timer = 100    
            m.vx = ((rand() / float: RAND_MAX) * 2.0)
            m.vy = ((rand() / float: RAND_MAX) * 2.0) - 0.5
        }
    }

    m.timer = m.timer - 1
}

void mouse_enflame(Mouse^ m)
{
    m.flaming = true
    m.timer = 100
}

void mouse_draw(Mouse^ m, SDL_Surface^ sf, SDL_Surface^ lit)
{
    mouse[m.cook].x = m.x
    mouse[m.cook].y = m.y
    sprite_draw(sf, mouse[m.cook])    

    if(m.flaming){
        if((m.timer / 10) % 2 == 0)
        {
            fire_draw(sf, lit, 0, m.x, m.y)
        } else
        {
            fire_draw(sf, lit, 1, m.x, m.y)
        }
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

void mice_draw(SDL_Surface^ sf, SDL_Surface^ lit)
{
    list_begin(mice)
    while(!list_end(mice))
    {
        Mouse^ m = list_get(mice)
        mouse_draw(m, sf, lit)
        list_next(mice)
    }
}
