clc;
clear All;
close All;


exactfn=@(x)(sin(x));
fn=@(x)(sin(x));


N=[5 10 15 20 25 30 35 40 45 80 160 320];
%N=[5];
error=zeros;
for jt=1:length(N)
n=N(jt);
h=(2*pi)/n;

xa=0;
xb=2*pi;

y_0=0;
y_n=0;

a=-1;
b=2;
c=-1;


x=(xa:h:xb);
%here y(x_0)=y(1) , y(x_1)=y(2) ..... y(x_n)=y(n+1)

B=zeros;

% we clear that x_0=>x(1) ,x_1=x(2),....x_n=x(n+1)
for it=1:n-1
    B(it)=(h^2)*(fn(x(it+1))+(1/12)*(fn(x(it)) -2*fn(x(it+1)) +fn(x(it+2))));
    %B(it)=fn(x(it+1));
end

B=B';
%Matrix of this system

A=diag(b*ones(n-1,1),0)+diag(a*ones(n-2,1),1)+diag(c*ones(n-2,1),-1);
y=A\B;
y=[y_0;y;y_n];
exact_val=(exactfn(x))';
error(jt)=max(abs(exact_val-y));
%plot(x,exact_val,'go');
%hold on;
%plot(x,y,'bx');
%legend('eaxt value','numarical value');
end

fprintf("       N              error \n      -----------------------\n");
for it=1:length(N)
    fprintf("   %8s    %12s\n",num2str(N(it)),num2str(error(it)));
end
loglog(error,N);