clc;
clear All;
close All;
fn=@(x,y)(4*y - 1);


xa=0;
xb=0.5;

h=0.05; %value of h
n=(xb-xa)/h; %no of iteration
yv=zeros(n,1);

xv=linspace(xa,xb,n)';
yv(1)=1;

for i=1:(n-1)
    yv(i+1)=yv(i)+h*fn(xv(i),yv(i));
end
fprintf("ans is : %s \n",num2str(yv(n)));