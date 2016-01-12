# strace

Niveau avancé

## Présentation
strace permet de suivre les appels systèmes et les signaux liés à un processus. 

## Exemple concret 

Je met un processus netcat en écoute local sur le port 1025, ensuite j'ouvre une connexion vers ce port et transmet chaine "pouet" ; après 1 seconde, je ferme la connexion. 

Je lance le process bidon
```
francegalop25:~# strace -s -v -t -s 5000 -o /tmp/out netcat -l -p 1025 &
```

J'en vérifie son execution
```
francegalop25:~# netstat -lntp | grep 1025
tcp        0      0 0.0.0.0:1025            0.0.0.0:*               LISTEN     21083/netcat
```

et j'envoi des données bidon
```
francegalop25:~# echo "pouet" | netcat -w 1 localhost 1025
pouet

### Analyse

```
Et enfin, on regarde la trace et on essaye de l'interpreter
```
francegalop25:~# cat /tmp/out
13:28:20 execve("/bin/netcat", ["netcat", "-l", "-p", "1025"], [/* 17 vars */]) = 0
13:28:20 uname({sys="Linux", node="francegalop25", ...}) = 0
13:28:20 brk(0)                         = 0x804e000
13:28:20 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
13:28:20 mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f39000
13:28:20 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
13:28:20 open("/etc/ld.so.cache", O_RDONLY) = 3
13:28:20 fstat64(3, {st_mode=S_IFREG|0644, st_size=25170, ...}) = 0
13:28:20 mmap2(NULL, 25170, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f32000
13:28:20 close(3)                       = 0
13:28:20 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
13:28:20 open("/lib/tls/i686/cmov/libc.so.6", O_RDONLY) = 3
13:28:20 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240O\1\0004\0\0\0\250\347\22\0\0\0\0\0004\0 \0\n\0(\0=\0<\0\6\0\0\0004\0\0\0004\0\0\0004\0\0\0@\1\0\0@\1\0\0\5\0\0\0\4\0\0\0
\3\0\0\0\340]\22\0\340]\22\0\340]\22\0\23\0\0\0\23\0\0\0\4\0\0\0\1\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\304m\22\0\304m\22\0\5\0\0\0\0\20\0\0\1\0\0\0\274v\22\0\274v\22\0\274v\22\0Tf\0\0\340\
221\0\0\6\0\0\0\0\20\0\0\2\0\0\0<\315\22\0<\315\22\0<\315\22\0\350\0\0\0\350\0\0\0\6\0\0\0\4\0\0\0\4\0\0\0t\1\0\0t\1\0\0t\1\0\0 \0\0\0 \0\0\0\4\0\0\0\4\0\0\0\7\0\0\0\330\262\22\0\330\262\22\
0\330\262\22\0\10\0\0\0(\0\0\0\4\0\0\0\4\0\0\0P\345td\364]\22\0\364]\22\0\364]\22\0\274\r\0\0\274\r\0\0\4\0\0\0\4\0\0\0Q\345td\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\6\0\0\0\4\0\0\0R\345td\
274v\22\0\274v\22\0\274v\22\0 Y\0\0 Y\0\0\4\0\0\0 \0\0\0\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\6\0\0\0\0\0\0\0\377\3\0\0m\10\0\0\5\1\0\0\214\6\0\0U\2\0\0\321\0\0\0\364\6\0\0\0\0\0\0\
0\0\0\0\0\0\0\0\0\0\0\0{\6\0\0\333\5\0\0\0\0\0\0%\10\0\0\205\6\0\0\23\2\0\0\247\2\0\0009\10\0\0\"\4\0\0.\10\0\0\0\0\0\0\272\6\0\0|\2\0\0\373\7\0\0\'\6\0\0\311\4\0\0", 512) = 512
13:28:20 fstat64(3, {st_mode=S_IFREG|0644, st_size=1241392, ...}) = 0
13:28:20 mmap2(NULL, 1247388, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e01000
13:28:20 mmap2(0xb7f28000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x127) = 0xb7f28000
13:28:20 mmap2(0xb7f2f000, 10396, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f2f000
13:28:20 close(3)                       = 0
13:28:20 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7e00000
13:28:20 mprotect(0xb7f28000, 20480, PROT_READ) = 0
13:28:20 set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e008e0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
13:28:20 munmap(0xb7f32000, 25170)      = 0
13:28:20 gettimeofday({1452601700, 691686}, NULL) = 0
13:28:20 getpid()                       = 22425
13:28:20 brk(0)                         = 0x804e000
13:28:20 brk(0x806f000)                 = 0x806f000
13:28:20 open("/etc/resolv.conf", O_RDONLY) = 3
13:28:20 fstat64(3, {st_mode=S_IFREG|0644, st_size=71, ...}) = 0
13:28:20 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f38000
13:28:20 read(3, "search ecritel.net\nnameserver 195.200.97.54\nnameserver 195.200.116.151\n", 4096) = 71
13:28:20 read(3, "", 4096)              = 0
13:28:20 close(3)                       = 0
13:28:20 munmap(0xb7f38000, 4096)       = 0
13:28:20 rt_sigaction(SIGINT, {0x8049160, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
13:28:20 rt_sigaction(SIGQUIT, {0x8049160, [QUIT], SA_RESTART}, {SIG_DFL}, 8) = 0
13:28:20 rt_sigaction(SIGTERM, {0x8049160, [TERM], SA_RESTART}, {SIG_DFL}, 8) = 0
13:28:20 rt_sigaction(SIGURG, {SIG_IGN}, {SIG_DFL}, 8) = 0
13:28:20 rt_sigaction(SIGPIPE, {SIG_IGN}, {SIG_DFL}, 8) = 0
13:28:20 open("/etc/nsswitch.conf", O_RDONLY) = 3
13:28:20 fstat64(3, {st_mode=S_IFREG|0644, st_size=475, ...}) = 0
```

Description des appels systèmes rencontrés :

* execve : execute program 
* uname : get name and information about current kernel
* access, faccessat : check user's permissions for a file
* brk, sbrk : change data segment size
* mprotect : set protection on a region of memory
* read : read from a file descriptor
* close : close a file descriptor
* mmap, munmap : map or unmap files or devices into memory
* sigaction, rt_sigaction : examine and change a signal action
* open, openat, creat : open and possibly create a file
* stat, fstat, lstat, fstatat : get file status

## ressources :
http://man7.org/linux/man-pages/man2/syscalls.2.html 

