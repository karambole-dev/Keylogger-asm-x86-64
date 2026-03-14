```
nasm -f elf64 keylogger.asm
```
```
ld keylogger.o -o keylogger
```
```
sudo ./keylogger </dev/null &
```
```
nasm -f elf64 keylogger.asm ; ld keylogger.o -o keylogger ; sudo ./keylogger
```