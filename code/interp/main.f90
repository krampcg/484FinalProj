program main
    use bezier 
    implicit none
    real(kind=kind(0.0d0)), allocatable, dimension(:, :, :) :: grad
    real(kind=kind(0.0d0)), allocatable, dimension(:, :) :: Z, derivsX, derivsY
    real(kind=kind(0.0d0)), allocatable, dimension(:) :: bezCurve, derivs, controlPoints
    integer :: space, spacePoints, i, j
    real(kind=kind(0.0d0)) :: dx, h, input, output, u, v

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !! Evaluate the Bezier Points
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    dx = 0.01
    space = 1
    spacePoints = int(1/dx) * space

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !! Evaluate the Bezier Curve, and write out the curve points
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    allocate(bezCurve(4))
    open(15, file='curvePoints.txt')
    open(16, file='bezCurve.dat')
    do i = 1, 4
        read(15, *) h
        bezCurve(i) = h
    end do

    do i = 0, 100
        input = real(i)/real(100)
        call evalCurve(bezCurve, input, output)
        write(16, *) output
    end do
    close(15)
    close(16)

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !! Precompute the deriv at each point on curve
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    open(17, file='1DDerivs.dat')
    call get1Dderivs(bezCurve, derivs, spacePoints)
    do i = 0, spacePoints
        write(17, *) derivs(i)
    end do
    close(17)

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !! Precompute the deriv at each point on the surface
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    allocate(derivsX(0:spacePoints, 0:spacePoints))
    allocate(derivsY(0:spacePoints, 0:spacePoints))
    allocate(controlPoints(16))
    
    open(21, file='controlPoints.txt')
    do i = 1, 16
        read(21, *) h
        controlPoints(i) = h
    end do
    close(21)

    do i = 0, spacePoints
        do j = 0, spacePoints
            u = real(i) / real(spacePoints)
            v = real(j) / real(spacePoints)
            call get2DderivsX(derivsX, i, j, u, v, spacePoints, controlPoints)
            call get2DderivsY(derivsY, i, j, u, v, spacePoints, controlPoints)
        end do
    end do
    
    open(18, file='2DDerivsX.dat')
    do i = 0, spacePoints
        write(18, *) derivsX(i, :)
    end do
    close(18)

    open(19, file='2DDerivsY.dat')
    do i = 0, spacePoints
        write(19, *) derivsY(i, :)
    end do
    close(19)

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !! Compute 3D Bezier Surface
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    call evalBezier(Z, spacePoints)
    call preCalcGrad(Z, spacePoints, grad) 
    
    deallocate(Z, grad, bezCurve, derivs, derivsX, derivsY)

end program main
