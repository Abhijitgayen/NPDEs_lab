clc;
clear All;
close All;
fn=@(x,y)(((-2)*x*y)/(1+x^2));

xa=0;
xb=1;

h=0.1; %value of h
n=(xb-xa)/h; %no of iteration
yv=zeros(n,1);

xv=linspace(xa,xb,n)';
yv(1)=1;

for i=1:(n-1)
    yv(i+1)=yv(i)+h*fn(xv(i),yv(i));
end
fprintf("ans is : %s \n",num2str(yv(n)));
