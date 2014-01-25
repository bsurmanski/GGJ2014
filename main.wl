import "sdl.wl"

import "matrix.wl"
import "sprite.wl"
import "owl.wl"

SDL_Surface^ screen = null
SDL_Surface^ buffer = null
int8^ keystate = null
bool running = true

Owl^ owl = null

void draw()
{
    SDL_BlitSurface(buffer, &buffer.clip_rect, screen, &screen.clip_rect)
    owl_draw(owl, screen)
    SDL_Flip(screen)
    SDL_FillRect(screen, null, 0)
}

void update()
{
    input() 
    owl_update(owl)
    SDL_Delay(32)
}

void input()
{
    SDL_PumpEvents()
    keystate = SDL_GetKeyState(0)
    if(keystate[SDLK_SPACE]) running = false
    if(keystate[SDLK_UP]) owl.y = owl.y + 1.0
    if(keystate[SDLK_RIGHT]) owl.x = owl.x + 1.0
}

int main(int argc, char^^ argv)
{
    screen = SDL_SetVideoMode(320, 240, 0, SDL_SWSURFACE)
    buffer = SDL_CreateRGBSurface(SDL_SWSURFACE, 320, 240, screen.format.BitsPerPixel,
        screen.format.Rmask, screen.format.Gmask, screen.format.Bmask, screen.format.Amask)

    owl = owl_new()

    SDL_WM_SetCaption("Jam", null)

    while(running)
    {
        input()
        update()
        draw()
    }

    return 0    
}
