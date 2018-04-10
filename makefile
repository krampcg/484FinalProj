FC90 = gfortran
main = bezier.f90 main.f90

all: main_exe

main_exe:$(main)
	$(FC90)	$(main)	-o	$@

clean:
	rm	*.mod	*_exe	*.dat
