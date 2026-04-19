#include <stdio.h>
#include <time.h>

int main() {
    time_t now = time(NULL);             // epoch time (detik sejak 1970)
    // struct tm *local = localtime(&now);  // pecah jadi tanggal lokal
    struct tm *utc = gmtime(&now); // versi UTC
    
    printf("Sekarang: %d-%02d-%02d %02d:%02d:%02d\n",
        utc->tm_year + 1900,
        utc->tm_mon + 1,
        utc->tm_mday,
        utc->tm_hour,
        utc->tm_min,
        utc->tm_sec);
    return 0;
}
