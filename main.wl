import "sdl.wl"

SDL_Surface ^surf = null
int8^ keystate = null
bool running = true

int main(int argc, char^^ argv)
{
    surf = SDL_SetVideoMode(320, 240, 0, SDL_SWSURFACE)
    SDL_WM_SetCaption("Jam", null)

    while(running)
    {
        SDL_Flip(surf);    
        SDL_Delay(32);
        SDL_PumpEvents();
        keystate = SDL_GetKeyState(0);
        if(keystate[SDLK_SPACE]) running = false
    }

    return 0    
}
