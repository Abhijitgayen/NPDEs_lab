clear All;
close All;
clc;
clear;
% Input Data
x_L=1;
alpha=0.02;
a=@(t) (0);
b=@(t) (0);
 
%dt=1.25;
dx=0.1;

while (1)
    dt=input('enter value of dt : ');
    r=(dt*alpha)/dx^2;
    if(r>0.5)
        fprintf('value of r is :%s\n ',num2str(r));
       break;
    end
end
nt=100;
t_f=dt*nt;

%The analytical solution is
c=100;
ua=@(x,t)(c*exp((-alpha*(pi)^2*t)/x_L^2)*sin((pi*x)/x_L));
g=@(x)(c.*sin((pi.*x)./x_L));

nx=x_L/dx;
t1=0:dt:t_f;
x1=0:dx:x_L;
u=zeros(nt+1,nx+1);
u(:,1)=a(t1');
u(:,end)=b(t1');
u(1,:)=g(x1);


% u(x_i,t_j+1)=ru(x_i+1,t_j)+(1-2r)u(x_i,t_j)+ru(x_i-1,t_j);
for it =2:nt+1
    for jt=2:nx
        u(it,jt)=r*u(it-1,jt+1)+(1-2*r)*u(it-1,jt)+r*u(it-1,jt-1);
    end
end

%part a)
fprintf('grid X    exactval    appxval\n--------------------------------------------------\n');
for it=1:nx+1
    exactval=ua(x1,10*dt);
    appxval=u(10,:);
    fprintf("%5s %12s %12s\n",num2str(x1(it)),num2str(exactval(it)),num2str(appxval(it)));
end

plot(x1,exactval,'-o',x1,appxval,'-x',x1,abs(exactval-appxval),'-x');

legend('exact val','appxval','abs erorr'); 