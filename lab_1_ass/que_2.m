clc;
clear All;
close All;


exactfn=@(x)(2* exp(x) -x - 1);
xa=0;
xb=1;

%h=input("enter the value of the h:");
h=1/3;

n=(xb-xa)/h;

a=1-(h/2);
b=-2;
c=1+(h/2);


x=(xa:h:xb);
%here y(x_0)=y(1) , y(x_1)=y(2) ..... y(x_n)=y(n+1)

y_0=1;
y_n=2*(exp(1)-1);

B=zeros;
B(1)=h^2-c*y_0;
for it=2:n-2
    B(it)=(h^2);
end
B(n-1)=h^2-(a*y_n);
B=B';
%Matrix of this system
% (n-1) X (n-1) matrix
n=n-1;
A=diag(b*ones(n,1),0)+diag(a*ones(n-1,1),1)+diag(c*ones(n-1,1),-1);
y=A\B;
y=[y_0;y;y_n];
exact_val=(exactfn(x))';
error=abs(exact_val-y);

fprintf("       x     numarical   exact_val   error \n----------------------------------------------\n");
for it=1:length(x)
    fprintf("   %8s   %8s   %8s   %8s\n",num2str(x(it)),num2str(y(it)),num2str(exact_val(it)),num2str(error(it)));
end
