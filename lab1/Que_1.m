clc;
clear All;
close All;
fn=@(x,y)((-2)*x*y);
sl=@(x) (exp((-1)*(x.^2)));% exact solution of this differential equation


xa=0;
xb=3;

n=100; %no of iteration
h=(xb-xa)/n; %value of h
yv=zeros(n,1);

xv=linspace(xa,xb,n)';
yv(1)=1;

for i=1:(n-1)
    yv(i+1)=yv(i)+h*fn(xv(i),yv(i));
end

exv=sl(xv);

error= (exv-yv)';
