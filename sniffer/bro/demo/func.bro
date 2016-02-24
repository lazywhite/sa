# Function implementation.
function emphasize(s: string, p: string &default = "*"): string
    {
    return p + s + p;
    }


function sayHello(): string
{
    #no single quota permitted
    return  "hello";
}

event bro_init() 
    { 
    # Function calls.
    print emphasize("yes");
    print emphasize("no", "_");
    print sayHello();
    }

