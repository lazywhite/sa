bro script is Event-driven
## special event

event bro_init(){
}
event bro_done(){
}


## load other script
@load misc/dump-events

## functions
function emphasize(s: string, p: string &default = "*"): string
    {
    return p + s + p;
    }
event bro_init() 
    { 
    # Function calls.
    print emphasize("yes");
    print emphasize("no", "_");
    }

## variables
global x = "Hello";

event bro_init()
    {
    print x;
    
    const y = "Guten Tag";
    # Changing value of 'y' is not allowed.
    #y = "Nope";

    local z = "What does that mean?";
    print z;
    }

event bro_done()
    {
    x = "Bye";
    print x;
    }

##  primitive datatype
event bro_init() 
    {
    local x : string = "two";
    local y : int = 10000000000000000000000000000000000000000000000000;
    print "y is a large int:", y;
    print "x is a short string:", x;
    
    #pattern matching 
    print /one|two|three/ == "two";  # T
    print /one|two|three/ == "ones"; # F (exact matching)
    print /one|two|three/ in "ones"; # T (embedded matching)
    print /[123].*/ == "2 two";  # T
    print /[123].*/ == "4 four"; # F
    }


## length of string
|reference_of_string}

## abs of number
|reference_of_int|

## For loop
event bro_init() 
    { 
    for ( character in "abc" )
        {
        print character;
        }
    }

## event
//you can define same event many times
//events have same name are execute in order of &priority
global myevent: event(s: string);

global n = 0;

event myevent(s: string) &priority = -10
    {
    ++n;
    }

event myevent(s: string) &priority = 10
    {
    print "myevent", s, n;
    }

event bro_init()
    {
    print "bro_init()";
    event myevent("hi");
    schedule 5 sec { myevent("bye") };
    }

event bro_done()
    {
    print "bro_done()";
    }


## Hook

hook just like event, but hook have same name  can be skipped 


## composite datatype

###set
//A set is a collection of unique values.
    local x: set[string] = { "one", "two", "three" };

###table
//A table is an associative collection that maps a set of unique indices 
//to other values. 

    local x: table[count] of string = { [1] = "one", 
                                        [3] = "three",
                                        [5] = "five" };
###vector
//has 0-base indexing, can have same value twice

    local x: vector of string = { "one", "two", "three" };

###record
//A record is a user-defined collection of named values of 
//heterogeneous types, similar to a struct in C

    type MyRecord: record {
    a: string;
    b: count;
    c: bool &default = T;
    d: int &optional;
};

### redefinition
const pi = 3.14 &redef;
redef pi = 3.1415;

event bro_init() 
    {
    const two = 2;
    #redef two = 1; # not allowed
    #pi = 5.5;      # not allowed
    print pi;
    print two;
    }


