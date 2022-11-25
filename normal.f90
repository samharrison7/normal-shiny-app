subroutine normal_pdf(x, n, loc, scale, pdf)
    use iso_c_binding, only: c_int, c_double
    integer(kind=c_int), intent(in) :: n     !! Length of the x array
    real(kind=c_double), intent(in) :: x(n)         !! x array to calculate normal over
    real(kind=c_double), intent(in) :: loc          !! loc paramter (mean)
    real(kind=c_double), intent(in) :: scale        !! scale parameter (width)
    real(kind=c_double), intent(inout) :: pdf(n)    !! PDF values to return
    real(kind=c_double), parameter  :: sqrt_2_pi = sqrt(2.0 * acos(-1.0))
    integer(kind=c_int) :: i                                    !! Iterator
    ! Calculate the PDF given these parameters
    do i = 1, n
        pdf(i) = exp(-0.5 * (((x(i) - loc) / scale) * ((x(i) - loc) / scale))) / (sqrt_2_pi * scale)
    end do
end subroutine