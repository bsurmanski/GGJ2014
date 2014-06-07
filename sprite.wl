use "importc"

import(C) "/usr/include/stdlib.h"
import(C) "/usr/include/string.h"
import(C) "/usr/include/stdio.h"
import(C) "/usr/include/math.h"
import(C) "/usr/include/SDL/SDL.h"
import(C) "/usr/include/SDL/SDL_image.h"

import "main.wl"

//extern SDL_Surface^ screen

int SDL_BlitSurface(SDL_Surface^ src, SDL_Rect^ srcrect, SDL_Surface^ dst, SDL_Rect^ dstrect)
    return SDL_UpperBlit(src, srcrect, dst, dstrect);

struct Sprite
{
    SDL_Surface^ img
    float x
    float y
    float z
    float r
}

struct SpriteManager
{
    SDL_Surface^ buffer
    SDL_Surface^^ sprites    
    char^^ filenames
    int size 
}

SpriteManager^ s_list = null

void init_manager()
{
    s_list = malloc(64)
    //s_list.buffer = SDL_CreateRGBSurface(SDL_SWSURFACE, 320, 240, screen.format.BitsPerPixel, 
    //    screen.format.Rmask, screen.format.Gmask, screen.format.Bmask, screen.format.Amask)
    s_list.sprites = null
    s_list.filenames = null
    s_list.size = 0
}

SDL_Surface^ manager_lookup(char^ filenm)
{
    IMG_Init(IMG_INIT_PNG)
    for(int i = 0; i < s_list.size; i++)
    {
        if(!strcmp(s_list.filenames[i], filenm))
        {
            return s_list.sprites[i]
        }
    }
    return SDL_Surface^: null
}

Sprite^ sprite_new(char^ filenm)
{
    if(s_list == SpriteManager^: null) init_manager()
    SDL_Surface^ s = manager_lookup(filenm)

    int n
    if(s == null)
    {
        n = s_list.size
        s_list.size = s_list.size + 1
        s_list.sprites = realloc(s_list.sprites, s_list.size * 32)
        s_list.filenames = realloc(s_list.filenames, s_list.size * 8)
        s = IMG_Load(filenm)
        s_list.sprites[n] = s
        s_list.filenames[n] = strdup(filenm)

    }

    //img = s

    Sprite^ sprite = malloc(64)
    sprite.img = s
    sprite.x = 0.0
    sprite.y = 0.0
    sprite.z = 0.0
    sprite.r = 0.0

    return sprite
}

void sprite_drawNormal(SDL_Surface ^dst, Sprite^ sp)
{
    SDL_Rect srcrect
    SDL_Rect dstrect

    srcrect.x = 0
    srcrect.y = 0
    srcrect.w = sp.img.w
    srcrect.h = sp.img.h

    dstrect.x = sp.x
    dstrect.y = sp.y
    dstrect.w = sp.img.w
    dstrect.h = sp.img.h

    SDL_BlitSurface(sp.img, &srcrect, dst, &dstrect)
}

void sprite_draw(SDL_Surface ^dst, Sprite^ sp)
{
    SDL_Rect srcrect
    SDL_Rect dstrect

    srcrect.x = 0
    srcrect.y = 0
    srcrect.w = sp.img.w
    srcrect.h = sp.img.h

    dstrect.x = sp.x - sp.img.w / 2.0
    dstrect.y = sp.y - sp.img.h / 2.0
    dstrect.w = sp.img.w
    dstrect.h = sp.img.h

    SDL_BlitSurface(sp.img, &srcrect, dst, &dstrect)
}
