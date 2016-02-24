global x = 100;


function var_test()
{
    local z = 10;
    print z;
    z += 1;
    print z;
}

event bro_init()
{
    print x;
    x += 1;
    print x;

    const y = "Guten Tag"; # this is a const variable
    var_test();
}

event bro_done()
{
    print x;
    x = 200;
    print x;
    var_test();
}



