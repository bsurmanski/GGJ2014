import "sprite.wl"
import "fire.wl"
import "sdl.wl"
import "list.wl"
import "fireball.wl"
import "halo.wl"
import "cstdlib.wl"
import "cstdio.wl"
import "cmath.wl"

Sprite^ bush = null
Sprite^ bushBurnt = null

List^ bushes = null
int nbushes = 0

struct Bush
{
    float x
    float y
    int timer
    int burnTimer
    bool burning
}

void bush_init()
{
    bush = sprite_new("res/bush.png") 
    bushBurnt = sprite_new("res/bushburnt.png") 
    bushes = list_new()
}

Bush^ bush_new()
{
    Bush ^b = malloc(32) 
    float rf = float: rand()
    float rm = float: RAND_MAX
    b.x = (rf / rm) * 320
    b.y = 0.0 - 10.0
    b.burnTimer = 100
    return b
}

void bush_enflame(Bush^ b)
{
    b.burning = true
    b.timer = 100
    b.burnTimer = 100
}

void bush_update(Bush^ b)
{
    b.y = b.y + 1
    b.timer--
    if(b.burning && b.burnTimer)
        b.burnTimer--
    if(b.timer < 0) b.timer = 100
}

uint bushTimer = 50
void bushes_update()
{
    bushTimer--
    if(nbushes < 6 && !bushTimer)
    {
        list_add(bushes, bush_new())
        nbushes++
    }
    if(bushTimer == 0) bushTimer = 50

    list_begin(bushes)
    while(!list_end(bushes))
    {
        Bush^ b = list_get(bushes)
        bush_update(b)
        if(b.y > 300) {
            list_remove(bushes)
            nbushes--
        }
        list_next(bushes)
    }
}

void bush_draw(Bush^ b, SDL_Surface^ dst, SDL_Surface^ lit)
{
    Sprite^ drawSprite = bush
    if(b.burnTimer == 0)
    {
        drawSprite = bushBurnt    
    }

    drawSprite.x = b.x
    drawSprite.y = b.y
    sprite_draw(dst, drawSprite)

    if(b.burning)
    {
        if((b.timer / 10) % 2)
        {
            fire_draw(dst, lit, 2, b.x, b.y)
        } else
        {
            fire_draw(dst, lit, 3, b.x, b.y)
        }
    }
}

void bushes_draw(SDL_Surface^ dst, SDL_Surface^ lit)
{
    list_begin(bushes)
    while(!list_end(bushes))
    {
        Bush^ b = list_get(bushes)
        bush_draw(b, dst, lit)
        list_next(bushes)    
    }
}
