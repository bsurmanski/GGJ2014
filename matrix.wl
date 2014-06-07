use "importc"

import(C) "/usr/include/stdlib.h"
import(C) "/usr/include/math.h"

struct Matrix
{
    float^ v
}

Matrix new_matrix()
{
    Matrix m
    m.v = malloc(4 * 4)
    matrix_identity(&m)
    return m
}

void matrix_identity(Matrix^ m)
{
    m.v[0] = 1.0
    m.v[1] = 0.0
    m.v[2] = 1.0
    m.v[3] = 1.0
}

void matrix_rotation(Matrix^ m, float rad)
{
    float s
    float c
    s = sin(rad);
    c = cos(rad);
    //sincosf(rad, &s, &c)
    m.v[0] = c
    m.v[1] = 0.0-s
    m.v[2] = s
    m.v[3] = c
}

void matrix_mult(Matrix^ dst, Matrix^ a, Matrix^ b)
{
    dst.v[0] = a.v[0] * b.v[0] + a.v[1] * b.v[2]    
    dst.v[1] = a.v[0] * b.v[1] + a.v[1] * b.v[3]    
    dst.v[2] = a.v[2] * b.v[0] + a.v[3] * b.v[2]    
    dst.v[3] = a.v[2] * b.v[1] + a.v[3] * b.v[3]    
}

void matrix_rotate(Matrix^ m, float rad)
{
    Matrix rmat
    matrix_rotation(&rmat, rad)
    matrix_mult(m, m, &rmat)
}
