import "sdl.wl"

import "cstdlib.wl"
import "cstdio.wl"
import "matrix.wl"
import "sprite.wl"
import "owl.wl"
import "fireball.wl"
import "list.wl"
import "bg.wl"
import "particle.wl"
import "mouse.wl"

SDL_Surface^ screen = null
SDL_Surface^ buffer = null
SDL_Surface^ light = null
int8^ keystate = null
bool running = true

Owl^ owl = null
List^ fireballs = null

int getPixel(SDL_Surface^ s, int i, int j)
{
    if(i < 0 || i > s.w || j < 0 || j > s.h) 
        return 0
    int ^r = &(s.pixels[i * s.format.BytesPerPixel + j * s.pitch])
    return ^r
}

void setPixel(SDL_Surface^ s, int i, int j, uint v)
{
    if(i < 0 || i > s.w || j < 0 || j > s.h) return
    int^ r = &(s.pixels[i * s.format.BytesPerPixel + j * s.pitch])
    ^r = v
}

int convolutePixel(int a, int b)
{
    int c
    uchar^ al = &a
    uchar^ bl = &b
    uchar^ cl = &c
    float mod = (float: bl[0]) / 255.0
    if(mod < 0.0) mod = 0.0
    if(mod > 1.0) mod = 1.0
    cl[0] = al[0] * mod
    cl[1] = al[1] * mod
    cl[2] = al[2] * mod
    cl[3] = al[3] * mod
    return c
}

void dolight()
{
    for(int j = 0; j < 240; j++)
        for(int i = 0; i < 320; i++)
        {
            int bpxl = getPixel(buffer, i, j)
            int lpxl = getPixel(light, i, j)
            int epxl = convolutePixel(bpxl, lpxl)
            setPixel(buffer, i, j, epxl)
        }
}

void scaleBlit()
{
    for(int j = 0; j < 480; j++)
    {
        for(int i = 0; i < 640; i++)
        {
            int pxl = getPixel(buffer, i / 2, j / 2) 
            setPixel(screen, i, j, pxl)
        }
    }
    //SDL_BlitSurface(buffer, &buffer.clip_rect, screen, &screen.clip_rect)
}

void draw()
{
    SDL_FillRect(buffer, null, 0)
    SDL_FillRect(light, null, 0)

    background_draw(buffer)
    owl_draw(owl, buffer)
    owl_light(owl, light)

    list_begin(fireballs)
    while(!list_end(fireballs))
    {
        fireball_draw(list_get(fireballs), buffer)
        fireball_light(list_get(fireballs), light)
        list_next(fireballs)
    }

    frag_draw(buffer)
    frag_light(light)

    dolight()
    scaleBlit()
    SDL_Flip(screen)
}

void update()
{
    input() 
    background_update()
    owl_update(owl)

    list_begin(fireballs)
    while(!list_end(fireballs))
    {
        if(fireball_update(list_get(fireballs)))
            list_remove(fireballs)
        list_next(fireballs)
    }

    SDL_Delay(16)
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
    screen = SDL_SetVideoMode(640, 480, 0, SDL_SWSURFACE)
    buffer = SDL_CreateRGBSurface(SDL_SWSURFACE, 320, 240, screen.format.BitsPerPixel,
        screen.format.Rmask, screen.format.Gmask, screen.format.Bmask, screen.format.Amask)
    light = SDL_CreateRGBSurface(SDL_SWSURFACE, 320, 240, screen.format.BitsPerPixel,
        screen.format.Rmask, screen.format.Gmask, screen.format.Bmask, screen.format.Amask)

    srand(0)
    background_init()
    particle_init()
    mice_init()
    owl = owl_new()
    fireballs = list_new()

    SDL_WM_SetCaption("Jam 2014", null)
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
