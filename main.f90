program main
    use bezier 
    implicit none
    real(kind=kind(0.0d0)), allocatable, dimension(:, :, :) :: grad
    real(kind=kind(0.0d0)), allocatable, dimension(:, :) :: Z
    integer :: space, spacePoints
    real :: dx

    dx = 0.01
    space = 1
    spacePoints = int(1/dx) * space

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !! Evaluate the Bezier Points
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    call evalBezier(Z, spacePoints)
    call preCalcGrad(Z, spacePoints, grad) 
    
    deallocate(Z, grad)

end program main
