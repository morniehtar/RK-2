module config
    implicit none
    public

    !Segment boundaries
    real(8), parameter :: fl = 0.d0, cl = 1.d0
    !Integration precision
    integer, parameter :: dots = 10
    !Runge-Kutta parameter (changes implement different integration methods)
    real(8), parameter :: omega = 1.d0
end module config

program output
    use config
    implicit none

    procedure(func), pointer :: fptr
    fptr => func

    call integ(fptr, fl, cl, omega)


contains
    ! y' = func(x, y)

    pure real(8) function func(x, y)
        implicit none
        real(8), intent(in) :: x, y
        !func = 2*x*y
        func = 5*x**4
    end function func

    subroutine integ(fptr, st, ed, par)
        !Blue line
        use config
        implicit none

        procedure(func), pointer, intent(in) :: fptr
        real(8), intent(in) :: st, ed, par
        real(8) :: x0, x, y, k1, k2, step
        integer :: i

        step = (ed - st) / dots

        !Initial conditions
        x0 = 0.d0
        y = 0.d0

        open(unit = 1, file = "output.dat")
        do i = 1, dots+1
            x = x0 + (i-1)*step
            write(1,*) x, y, sltn(x)
            k1 = fptr(x, y)
            k2 = fptr(x+step/(2*par), y+k1*step/(2*par))
            y = y + step*((1-par)*k1+par*k2)
        end do
        close(1)

    end subroutine integ

    pure real(8) function sltn(x)
        !Red line
        implicit none
        real(8), intent(in) :: x
        !sltn = exp(x**2)
        sltn = x**5
    end function sltn

end program output
