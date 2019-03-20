// KMP Algorithm
// Klaudia Głocka
// 221525


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void computeLPS(char* pattern, int m, int* lps){
    lps[0]=0;
    int lenght=0;
    int i=1;

    while(i<m){
        if(pattern[i] == pattern[lenght]){
            lenght++;
            lps[i]= lenght;
            i++;
        }else{
            if(lenght!=0){
                lenght= lps[lenght-1];
            }else{
                lps[i]=0;
                i++;
            }
        }
    }
}

void searchForPattern(char* pattern, char* text){
    int m= strlen(pattern);
    int n= strlen(text);

    int lps[m];

    computeLPS(pattern, m, lps);

    for(int k=0; k<m; k++){
        printf("%d", lps[k]);
    }
    printf("\n"); 

    int i=0, j=0;
    while(i<n){
        if(pattern[j]==text[i]){
            j++;
            i++;
        }

        if(j==m){
            printf("Znaleziono wzorzec na pozycji %d\n", i - j);
            j= lps[j-1];
        }else if(j<n && pattern[j]!= text[i]){
            if(j!=0)
                j=lps[j-1];
            else
                i=i+1;
        }
    }
}

int main(int argc, char **argv) {
    char *pattern = argv[1];
    char *text = argv[2];

    searchForPattern(pattern, text);
    return EXIT_SUCCESS;
}
