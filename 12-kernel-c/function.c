int recursice(int a) {
    if (a > 10) {
        return 1;
    } else {
        return recursice(a+1) + 1;
    }
}

int my_function() {
    int k = 15;
    int g = 10;
    int h = k - g; 
    int a = recursice(g);
    k -= 12;
    int b = recursice(k);
    return 0xbaba;
}
