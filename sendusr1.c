/*
 * Send SIGUSR1 to a running rdservice process.
 *
 * For best performance, the executable should have the capability CAP_KILL set.
 *
 * Use sudo set-cap cap_kill+ep /path/to/sendusr1
 */

#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>

#include <signal.h>

int main(int argc, char *argv[]) {
  if (argc == 2) {
    pid_t pid = (pid_t)strtol(argv[1], NULL, 10);

    printf("pid: %d\n", pid);

    kill(pid, SIGUSR1);
  }
  return(0);
}
