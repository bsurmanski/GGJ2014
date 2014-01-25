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
    List^ l = malloc(16)
    l.first = null
    l.ptr = null
    return l
}

void list_add(List^ l, void^ v)
{
    Node ^n = malloc(32)
    n.prev = null
    n.next = l.first
    if(l.first != null)
        l.first.prev = n
    n.val = v
    l.first = n
}

void list_begin(List^ l)
{
    if(l != null)
        l.ptr = l.first
}

bool list_end(List ^l)
{
    return l.ptr == null    
}

void^ list_next(List ^l)
{
    if(l.ptr != null) {
        l.ptr = l.ptr.next
        if(l.ptr != null)
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
    void^ val = l.ptr.val
    Node^ prev = l.ptr.prev
    Node^ next = l.ptr.next
    Node^ n = l.ptr

    if(prev != null)
    {
        prev.next = next
    } else
    {
        l.first = next
    }

    if(next != null)
        next.prev = prev

    l.ptr = next

    return val
}
