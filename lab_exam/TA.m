function R = TA(x,t)
 beta=5.2*10^(-4);
 R=(exp(cos(t)).*((x-x.^2)/(2.*beta)));
end

