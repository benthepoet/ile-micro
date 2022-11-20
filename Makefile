monitor.bin: monitor.obj
	wlalink linkfile bin/monitor.bin

monitor.obj:
	wla-z80 -o bin/monitor.obj src/monitor.s

