clear All;
close All;
clc;
clear;
% Input Data
N=[4,8,16,32,64,128];

x_L=1;
alpha=1;
a=@(t) (0);
b=@(t) (0);
g=@(x) sin(pi*x);
t_f=1;

%The analytical solution is
ua=@(x,t)(sin((pi).*x).*exp((-1).*((pi).^2).*t));

inf_error=zeros(1,length(N));
norm_error=zeros(1,length(N));
h=1./N;
for t=1:length(N)
    dx=h(t);
    dt=dx*dx;
    nx=x_L/dx;
    r=(alpha*dt)/(dx^2);
    t1=0:dt:t_f;
    x1=0:dx:x_L;
    nt=length(t1)-1;
    
    u_i=zeros;
    u_0=g(x1);

    A=zeros(nx-1,nx-1)+diag(ones(nx-1,1)*(-1-2*r),0)+diag(ones(nx-2,1)*r,-1)+diag(ones(nx-2,1)*r,1);
    % u(t,x) is deternuned sequentially
    %for backward method
    for it=2:nt+1
        B=-u_0(2:nx)';
        B(1)=B(1)-r*a(t1(it));
        B(end)=B(end)-r*b(t1(it));
        u1 =(A\B);
        u_i =[ a(t1(it)) u1' b(t1(it))];
        u_0=u_i;
    end
    %calculate all error for each t_f=1
    calua=ua(x1,t1(it));
    error=abs(calua-u_i);
    %error calculation
    %inf norm
    inf_error(t)=max(error);
    %L 2_norm
    err=0;
    for jt=1:length(error)
        err=err+(error(jt))^2;
    end
    err=(err*dx)^(1/2);
    norm_error(t)=err;
end

%EOC calculation 
EOC=zeros(1,length(N));
EOC(1)=0;
for it=1:length(N)-1
    EOC(it+1)=((log(norm_error(it)/norm_error(it+1)))/(log(h(it)/h(it+1))));
end

fprintf("   h   norm_inf_error    norm_2_error    EOC\n-----------------------------------------------------------------\n");
for it= 1:length(N)
    fprintf("%10d %10s %10s %10s\n",h(it),inf_error(it),norm_error(it),EOC(it));
end
plot(log(h),log(inf_error),'-*',log(h),2*log(h)-6,'--');
