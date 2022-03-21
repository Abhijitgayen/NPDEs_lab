function R=k_left(x,t)
beta=5.2*10^(-4);
gama=(1.2*10^(-3)*3.4);
R=(exp(cos(t)).*(gama.*sin(t).*((x-x.^2)/(2.*beta))+1))*(1/gama);
end