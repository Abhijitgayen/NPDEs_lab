clear All;
close All;
clc;
clear;
% Input Data
x_L=1;
alpha=(1/(pi)^2);
a=@(t) (0);
b=@(t) (0);
g=@(x) cos(pi*(x - (1/2)));
%The analytical solution is
ua=@(x,t)(cos(pi*(x-(1/2)))* exp(-t));


%for forword method

nx=10;
nt=150;
dx=x_L/nx;
r=0.25;
dt=(r*(dx)^2)/alpha;
t_f=dt*nt;
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

error=zeros();
f=figure;

for it=1:nt+1
    calua=ua(x1,t1(it));
    plot(x1,u(it,:),'-or',x1,calua,'-xg');
    legend('appx val','exact val');
    error(it)=max(abs(calua-u(it,:)));
    pause(0.1);
end
title('Heat Equation 2D views for forword');
xlabel('X - space');
ylabel('t - time');

f2=figure;
%eroor graph according to changing t
plot(t1(1:end-1),error(1:end-1));
title('Graph of error and time for backword');
xlabel('t - time');
ylabel('E - error');
