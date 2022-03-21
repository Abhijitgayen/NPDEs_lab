clc;
clear All;
close All;

exactfn=@(x)(exp(10*x)-1)/(exp(10)-1);

h=input("Enter value of h :");
y_0=0;
y_n=1;

xa=0;
xb=1;

n=(xb-xa)/h;
x=(xa:h:xb)';

fprintf("for Backword diff approximation\n");
a=1+10*h;
b=-(2+10*h);
c=1;


B=zeros(n-1,1);

B(1)=(-1)*a*y_0;
B(n-1)=(-1)*c*y_n;
%size of the martix be also n-1 x n-1
A=diag(b*ones(n-1,1),0)+diag(a*ones(n-2,1),-1)+diag(c*ones(n-2,1),1);
y=A\B;
y_B=[y_0;y;y_n];

fprintf("for forword diff approximation\n");
c=1-10*h;
b=-2+10*h;
a=1;


B=zeros(n-1,1);
B(1)=(-1)*a*y_0;
B(n-1)=(-1)*c*y_n;

%size of the martix be also n-1 x n-1

A=diag(b*ones(n-1,1),0)+diag(a*ones(n-2,1),-1)+diag(c*ones(n-2,1),1);

y=A\B;
y_F=[y_0;y;y_n];

fprintf("for central diff approximation\n");
c=1-5*h;
b=-2;
a=1+5*h;


B=zeros(n-1,1);
B(1)=(-1)*a*y_0;
B(n-1)=(-1)*c*y_n;
%size of the martix be also n-1 x n-1
A=diag(b*ones(n-1,1),0)+diag(a*ones(n-2,1),-1)+diag(c*ones(n-2,1),1);
y=A\B;
y_C=[y_0;y;y_n];



plot(x,y_B,'-Or',x,y_C,'-+b',x,y_F,'--r',x,exactfn(x),'-Xg','MarkerSize',10)
legend('Backword','central','foword','Exact value')