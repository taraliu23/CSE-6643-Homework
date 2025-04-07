#----------------------------------------
# Problem a
#----------------------------------------
# This function takes in a matrix T and modifies it 
# in place to Hessenberg form using Householder reduction.
function hessenberg_form!(T)

end

#----------------------------------------
# Problem b
#----------------------------------------
# This funciton takes in a matrix T in Hessenberg form
# and runs a single iteration of the unshifted QR Algorithm 
# using Givens rotations
function givens_qr!(T)


end

#----------------------------------------
# Problem c
#----------------------------------------
# This function takes in a matrix T in Hessenberg form and 
# implements the practical QR algorithm with shifts. 
# The input shift dictates which shift type your 
# algorithm should use. For shift = "single" implement the single shift 
# and for shift = "wilkinson" implement the Wilkinson shift
function practical_QR_with_shifts!(T,shift)

        if shift == "single"
        	#Set single shift here
        	
        elseif shift == "wilkinson"
        	#Set wilkinson shift here

        end
end
#----------------------------------------
# Problem d
#----------------------------------------


