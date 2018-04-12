program main
    use bezier 
    implicit none
    real(kind=kind(0.0d0)), allocatable, dimension(:, :, :) :: grad
    real(kind=kind(0.0d0)), allocatable, dimension(:, :) :: Z
    real(kind=kind(0.0d0)), allocatable, dimension(:) :: bezCurve, derivs
    integer :: space, spacePoints, i
    real(kind=kind(0.0d0)) :: dx, h, input, output

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

    open(17, file='2DDerivs.dat')
    call get2Dderivs(bezCurve, derivs, spacePoints)
    do i = 0, spacePoints
        write(17, *) derivs(i)
    end do
    close(17)

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !! Compute 3D Bezier Surface
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    call evalBezier(Z, spacePoints)
    call preCalcGrad(Z, spacePoints, grad) 
    
    deallocate(Z, grad, bezCurve, derivs)

end program main
