#include "test/*asdf*/header.h"
#include <stdio.h>

/** \brief Java 
*
*
*style Doc String - Foo function */
int foo();

int bar(); /**< Bar function */

/// .NET Style Doc String 

int global_var = 1;

/* Hello
/* World
// */
int baz();
// */

int main(int argc, const char* argv)
{
    printf("/* foo bar\" ");
    //*/ bar();

    // \
    /*
    baz();
    /*/
    foo();
    //*/

	/*
	*Multi comment
	*/
    return 1;
}
