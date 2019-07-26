void reverse(char s[]) {
  int len = stlen(s);
  for(int i = 0; i < len/2; ++i) 
  {
    char temp = s[len - i];
    s[len - i] = s[i];
    s[i] = temp;
  }
}

int strlen(char s[]) {
  int index = 0;
  while(s[index] != '\0') { ++index; }
  return index;
}