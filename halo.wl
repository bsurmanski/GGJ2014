import "sprite.wl"
import "sdl.wl"
import "cstdlib.wl"

Sprite^^ halos = null

void halo_init()
{
    halos = malloc(8 * 12)
    halos[0] = sprite_new("res/halo16.png")
    halos[1] = sprite_new("res/halo32.png")
    halos[2] = sprite_new("res/halo48.png")
    halos[3] = sprite_new("res/halo64.png")
    halos[4] = sprite_new("res/halo80.png")
    halos[5] = sprite_new("res/halo96.png")
    halos[6] = sprite_new("res/halo112.png")
    halos[7] = sprite_new("res/halo128.png")
    halos[8] = sprite_new("res/halo160.png")
    halos[9] = sprite_new("res/halo192.png")
    halos[10] = sprite_new("res/halo256.png")
}

void halo_draw(SDL_Surface^ dst, int i, float x, float y)
{
    halos[i].x = x
    halos[i].y = y
    sprite_draw(dst, halos[i])
}
