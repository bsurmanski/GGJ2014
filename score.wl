import "sdl.wl"
import "sprite.wl"
import "cstdlib.wl"
import "cmath.wl"

Sprite^^ numbers = null
Sprite^ scoreName = null
uint score = 0

void score_init()
{
    numbers = malloc(8 * 16)    
    scoreName = sprite_new("res/score.png")
    numbers[0] = sprite_new("res/number0.png")
    numbers[1] = sprite_new("res/number1.png")
    numbers[2] = sprite_new("res/number2.png")
    numbers[3] = sprite_new("res/number3.png")
    numbers[4] = sprite_new("res/number4.png")
    numbers[5] = sprite_new("res/number5.png")
    numbers[6] = sprite_new("res/number6.png")
    numbers[7] = sprite_new("res/number7.png")
    numbers[8] = sprite_new("res/number8.png")
    numbers[9] = sprite_new("res/number9.png")
}

void score_set(uint i)
    score = i

void score_add(uint i)
    score = score + i

void score_drawOffset(SDL_Surface^ dst, SDL_Surface^ lit, int x, int y)
{
    scoreName.x = x
    scoreName.y = y
    sprite_drawNormal(dst, scoreName)
    sprite_drawNormal(lit, scoreName)

    uint sbuf = score
    uint ndig = floor(log10(score)) + 1
    uint dign = 1
    while(sbuf)
    {
        uint sdig = sbuf % 10
        sbuf = sbuf / 10
        numbers[sdig].x = 48 + x + (8 * (ndig - dign))
        numbers[sdig].y = y
        sprite_drawNormal(dst, numbers[sdig])
        sprite_drawNormal(lit, numbers[sdig])
        dign++
    }

    if(score == 0)
    {
        numbers[0].x = 48 + x
        numbers[0].y = y
        sprite_drawNormal(dst, numbers[0])
        sprite_drawNormal(lit, numbers[0])
    }
    
}

void score_draw(SDL_Surface^ dst, SDL_Surface^ lit)
{
    score_drawOffset(dst, lit, 0, 0)
}
