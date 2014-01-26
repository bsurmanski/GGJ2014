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
uint nmice = 0
uint micemax = 5

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
    mouse[1] = sprite_new("res/mousecooked.png")
    mouse[2] = sprite_new("res/mouseburnt.png")
}

Mouse^ mouse_new()
{
    Mouse^ m = malloc(32)
    float r = rand()
    m.x = ((r / float: RAND_MAX) * 320.0)
    m.y = 0 - 20
    r = rand()
    m.vx = ((r / float: RAND_MAX) * 1.0) - 0.5
    m.vy = 0.1
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
            if(m.cook == 0)
            { 
                m.cook = 1
                m.timer = 50
            } else if(m.cook = 1)
            {
                m.cook = 2
                m.flaming = false
                m.timer = 50
                
            } else
            {
                m.timer = 50    
            }
            m.vx = 0
            m.vy = 0
        } else if(m.cook == 0)
        {
            m.timer = 100    
            float r = rand()
            m.vx = ((r / float: RAND_MAX) * 1.0) - 0.5
            //m.vx = ((r / float: RAND_MAX) * 2.0)
            r = rand()
            m.vy = ((r / float: RAND_MAX) * 2.0) - 0.5
        }
    }

    m.timer = m.timer - 1
}

void mouse_enflame(Mouse^ m)
{
    m.flaming = true
    m.timer = 30
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

uint miceTimer = 50
void mice_update()
{
    miceTimer--
    if(nmice < micemax && !miceTimer)
    {
        list_add(mice, mouse_new())  
    }
    if(miceTimer == 0) miceTimer = 50

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
