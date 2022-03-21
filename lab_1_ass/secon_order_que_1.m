function [y,x,h]=secon_order_que_1(n,xa,xb)

h=((xb-xa)/n);
x=(xa:h:xb);

%here y(x_0)=y(1) , y(x_1)=y(2) ..... y(x_n)=y(n+1)

%Matrix of this system
a=1;
b=(h^2-2);
c=1;
%B=(h.^2.*(1+x(2:n)))';
B=zeros;
for it=2:n
    B(it-1)=(h^2)*(1+x(it));
end
B=B';
A=diag(b*ones(n-1,1),0)+diag(a*ones(n-2,1),1)+diag(c*ones(n-2,1),-1);
y=A\B;
end