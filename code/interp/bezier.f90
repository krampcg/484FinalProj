module bezier
    implicit none

contains

subroutine evalBezier(Z, spacePoints)
    real(kind=kind(0.0d0)), allocatable, dimension(:,:), intent(out) :: Z
    real(kind=kind(0.0d0)), allocatable, dimension(:) :: controlPoints
    integer :: i, j, indexi, indexj, spacePoints
    real(kind=kind(0.0d0)) :: u, v, pt, h
    allocate(Z(spacePoints, spacePoints))
    allocate(controlPoints(16))
    open(13, file='controlPoints.txt')

    do i = 1, 16
        read(13, *) h
        controlPoints(i) = h
    end do

    do i = 1, spacePoints
        do j = 1, spacePoints
            u = real(i) / real(spacePoints)
            v = real(j) / real(spacePoints)
            call evalSurface(controlPoints, u, v, i, j, Z, spacePoints)
        end do
    end do
        
    
    close(13)
    open(11, file='bezierPoints.dat')
    do i = 1, spacePoints       
        write(11, *) Z(i, :)
    end do
    close(11)

end subroutine evalBezier

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! Bezier Curve
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine evalCurve(P, t, outPt)
    real(kind=kind(0.0d0)), allocatable, dimension(:) :: P
    real(kind=kind(0.0d0)) :: t, outPt
    outPt = (1-t)**3*P(1) + &
            3*t*(1-t)**2*P(2) + &
            3*t**2*(1-t)*P(3) + &
            t**3*P(4)

end subroutine evalCurve


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! Bezier Surface
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine evalSurface(controlPoints, u, v, i, j, Z, spacePoints)
    real(kind=kind(0.0d0)), allocatable, dimension(:), intent(in) :: controlPoints
    real(kind=kind(0.0d0)), allocatable, dimension(:,:) :: Z
    real(kind=kind(0.0d0)), allocatable, dimension(:) :: Pu, P
    integer :: spacePoints, k
    integer, intent(in) :: i, j
    real(kind=kind(0.0d0)) :: outPt, u, v
    allocate(Pu(4), P(4))
    do k = 0, 3
        P(1) = controlPoints(k * 4 + 1)
        P(2) = controlPoints(k * 4 + 2)
        P(3) = controlPoints(k * 4 + 3)
        P(4) = controlPoints(k * 4 + 4)
        call evalCurve(P, u, outPt)
        Pu(k+1) = outPt
    end do

    call evalCurve(Pu, v, outPt)
    Z(i, j) = outPt

end subroutine evalSurface

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! Gradient Pre calc
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine preCalcGrad(Z, spacePoints, grad)
    real(kind=kind(0.0d0)), allocatable, dimension(:,:), intent(in) :: Z
    real(kind=kind(0.0d0)), allocatable, dimension(:,:, :), intent(out) :: grad
    integer :: spacePoints, i, j
    real :: east, west, north, mini

    allocate(grad(spacePoints, spacePoints, 3))

    do i = 2, spacePoints-1
        do j = 2, spacePoints-1
            grad(i, j, 1) = Z(i-1, j) - Z(i, j)
            grad(i, j, 2) = Z(i, j+1) - Z(i, j)
            grad(i, j, 3) = Z(i+1, j) - Z(i, j)
            mini = min(grad(i, j, 1), grad(i, j, 2), grad(i, j, 3))
            if (mini < 1) then
                grad(i, j, :) = grad(i, j, :) + abs(1.0d0 - mini)
            end if
        end do
    end do
    grad = 1/grad

end subroutine preCalcGrad

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! Precomputes derivatives of a 2D seafloor
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine get2DDerivs(bezCurve, derivs, spacePoints)
    real(kind=kind(0.0d0)), allocatable, dimension(:) :: bezCurve, derivs
    integer :: i, spacePoints
    real :: t
    allocate(derivs(0:spacePoints))

    do i = 0, spacePoints
        t = real(i)/real(spacePoints)
        derivs(i) = -3*(t-1)**2*bezCurve(1) + &
                    3*(t-1)*(3*t-1)*bezCurve(2) + &
                    -3*t*(3*t-2)*bezCurve(3) + &
                    3*t**2*bezCurve(4)
    end do

    derivs(:) = derivs(:) / spacePoints

end subroutine get2DDerivs

end module bezier

