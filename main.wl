import "sdl.wl"

import "cstdlib.wl"
import "cstdio.wl"
import "matrix.wl"
import "sprite.wl"
import "owl.wl"
import "fireball.wl"
import "list.wl"

SDL_Surface^ screen = null
SDL_Surface^ buffer = null
int8^ keystate = null
bool running = true

Owl^ owl = null
List^ fireballs = null

void draw()
{
    SDL_BlitSurface(buffer, &buffer.clip_rect, screen, &screen.clip_rect)
    owl_draw(owl, screen)
    list_begin(fireballs)
    while(!list_end(fireballs))
    {
        fireball_draw(list_get(fireballs), screen)
        list_next(fireballs)
    }
    SDL_Flip(screen)
    SDL_FillRect(screen, null, 0)
}

void update()
{
    input() 
    owl_update(owl)
    list_begin(fireballs)
    while(!list_end(fireballs))
    {
        fireball_update(list_get(fireballs))
        list_next(fireballs)
    }
    SDL_Delay(32)
}

float OWLSPEED = 2.0
void input()
{
    SDL_PumpEvents()
    keystate = SDL_GetKeyState(0)
    if(keystate[SDLK_SPACE]) running = false
    if(keystate[SDLK_UP]) owl.y = owl.y - OWLSPEED
    if(keystate[SDLK_DOWN]) owl.y = owl.y + OWLSPEED
    if(keystate[SDLK_RIGHT]) owl.x = owl.x + OWLSPEED
    if(keystate[SDLK_LEFT]) owl.x = owl.x - OWLSPEED
    if(owl.x < 0) owl.x = 0
    if(owl.x > 320) owl.x = 320
    if(owl.y < 0) owl.y = 0
    if(owl.y > 240) owl.y = 240
    if(keystate[SDLK_a]) addFireball()
}

void addFireball()
{
    list_add(fireballs, fireball_new(owl.x, owl.y))
}

void init()
{
    screen = SDL_SetVideoMode(320, 240, 0, SDL_SWSURFACE)
    buffer = SDL_CreateRGBSurface(SDL_SWSURFACE, 320, 240, screen.format.BitsPerPixel,
        screen.format.Rmask, screen.format.Gmask, screen.format.Bmask, screen.format.Amask)

    owl = owl_new()
    fireballs = list_new()

    SDL_WM_SetCaption("Jam", null)
}

int main(int argc, char^^ argv)
{
    init()
    while(running)
    {
        input()
        update()
        draw()
    }

    return 0    
}
