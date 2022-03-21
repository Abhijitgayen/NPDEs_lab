clear All;
close All;
clc;
clear;
% Input Data
x_L=2;
alpha=1;
a=@(t) (0);
b=@(t) (0);
g=@(x) sin((pi/2)*x);
%The analytical solution is
ua=@(x,t)(sin((pi./2).*x).*exp((-1).*((pi./2).^2).*t));


nx=20;
nt=250;
dx=x_L/nx;
r=0.35;
dt=r*(dx)^2;
t_f=dt*nt;
t1=0:dt:t_f;
x1=0:dx:x_L;

u=zeros(nt+1,nx+1);
u(:,1)=a(t1');
u(:,end)=b(t1');
u(1,:)=g(x1);

%U_i+1=A*U_i
%zeros(n,m),ones(n,m),eye(n) 


% u(x_i,t_j+1)=ru(x_i+1,t_j)+(1-2r)u(x_i,t_j)+ru(x_i-1,t_j);
for it =2:nt+1
    for jt=2:nx
        u(it,jt)=r*u(it-1,jt+1)+(1-2*r)*u(it-1,jt)+r*u(it-1,jt-1);
    end
end

error=zeros();
for it=1:nt+1
    calua=ua(x1,t1(it));
    plot(x1,u(it,:),'-or',x1,calua,'-xg');
    legend('appx val','exact val');
    error(it)=max(abs(calua-u(it,:)));
    pause(0.05);
end
title('Heat Equation 2D views for forword');
xlabel('X - space');
ylabel('t - time');
hold off


%eroor graph according to changing t
plot(t1(1:end-1),error(1:end-1));
title('Graph of error and time ');
xlabel('E - error');
ylabel('t - time');
