#include <stdio.h>

int main() {
  int* a = new int[10];
  a[0] = 1;
  delete[] a;
  printf("a: %d\n", a[0]);
  return 0;
}
