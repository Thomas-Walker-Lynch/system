#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>
#include <stdio.h>

int main(){
  struct passwd *pw = getpwuid(getuid());
  const char *homedir = pw->pw_dir;
  puts(homedir);
  return 0;
}
