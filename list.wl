import "cstdlib.wl"

struct Node
{
    void^ next
    void^ prev
    void^ val
}

struct List
{
    Node^ first
    Node^ ptr
}

List^ list_new()
{
    List^ l = malloc(8)
    l.first = null
    l.ptr = null
    return l
}

void list_add(List^ l, void^ v)
{
    Node ^n = malloc(32)
    n.prev = null
    n.next = l.first
    n.val = v
    l.first = n
}

void list_begin(List^ l)
{
    l.ptr = l.first    
}

bool list_end(List ^l)
{
    return l.ptr == null    
}

void^ list_next(List ^l)
{
    if(!(l.ptr == null)) {
        l.ptr = (Node^: l.ptr).next
        if(!(l.ptr == null))
            return l.ptr.val
    }
    return int8^: null
}

void^ list_get(List^ l)
{
    return l.ptr.val    
}

void^ list_remove(List ^l)
{
    void^ val = (Node^: l.ptr).val
    Node^ cont = (Node^: l.ptr).next
    if(!(l.ptr.prev == null))
    {
        (Node^: l.ptr.prev).next = (Node^:l.ptr).next
    }

    if(!(l.ptr.next == null))
    {
        (Node^: l.ptr.next).prev = (Node^:l.ptr).prev 
    }

    l.ptr = cont
    return val
}
