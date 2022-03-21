clear All;
close All;
clc;
clear;
% Input Data
N=[4,8,16,32,64,128];

x_L=1;
gama=(1.2*10^(-3)*3.4);
row=(5*10^(-7)*4.2);
beta=5.2*10^(-4);
t_f=1;

%The analytical solution is
%TA=@(x,t)(exp(cos(t)).*((x-x.^2)/(2.*beta)));

%left part of homogeneous
%K=@(x,t)(exp(cos(t)).*(gama.*sin(t).*((x-x.^2)/(2.*beta))+1))*(1/gama);
inf_error=zeros(1,length(N));
h=1./N;
for t=1:length(N)
    dx=h(t);
    dt=dx;
    r=(2*(beta/gama)*dt)/(dx^2);
    t1=0:dt:t_f;
    x1=0:dx:x_L;
    nt=length(t1);
    nx=length(x1);
    
    u=zeros(nt,nx);
    u(:,1)=0;
    u(:,end)=0;
    u(1,:)=TA(x1,t1(1));
    u(2,:)=TA(x1,t1(2));

    %A matrix
    A=zeros(nx-2,nx-2)+diag((r/(1+r))*ones(nx-3,1),1)+ diag((r/(1+r))*ones(nx-3,1),-1);
    %B matrix
    B=diag(((1-r)/(1+r))*ones(nx-2,1),0);

    % u(x_i,t_j+1)=ru(x_i+1,t_j)+(1-2r)u(x_i,t_j)+ru(x_i-1,t_j);
    for it =3:nt
        u(it,2:nx-1)=A*u(it-1,2:nx-1)'+B*u(it-2,2:nx-1)'-k_left(x1(2:nx-1),t1(it))';
        %plot(x1,u(it,:),'*',x1,TA(x1,t1(it)));
    end

    %calculate all error for each t_f=1
    calua=TA(x1,t1(it));
    error=abs(calua-u(nt));
    %error calculation
    %inf norm
    inf_error(t)=max(error);
end

%EOC calculation 
EOC=zeros(1,length(N));
EOC(1)=0;
for it=1:length(N)-1
    EOC(it+1)=((log(inf_error(it)/inf_error(it+1)))/(log(h(it)/h(it+1))));
end

fprintf("   h   norm_inf_error     EOC\n-----------------------------------------------------------------\n");
for it= 1:length(N)
    fprintf("%10d  %10s %10s\n",h(it),inf_error(it),EOC(it));
end
%plot(log(h),log(inf_error),'-*',log(h),2*log(h)-6,'--');
% i think i make mistake in any function .