close all;
clc;



for l=1:7
    N=2^(l+2) -1;
    a=0;
    b=1;
    alpha=1;
    Tf=1;
    mu=1;
    h=(b-a)/(N+1);
    dt=h*h;
    x=linspace(a,b,N+2);
    
    low=-mu*ones(N,1);
    up=-mu*ones(N,1);
    main=1+2*mu*ones(N,1);
    B=spdiags([low,main,up],-1:1,N,N);
    U=sin(pi*x');
    t=0;

    while t <= Tf
        Uold=U;
        U(2:N+1)=B\Uold(2:N+1);
        t=t+dt;
    end



    Ue=exp(-pi^2*t)*sin(pi*x)';
    e(l)=max(abs(Ue-U));



    for j=1:l-1
        Order(j)=log(e(j)/e(j+1))/log(2);
    end
    E(l)=norm(Ue-U,2);
end

error=e';
error1=E';
EOC=Order';
EOC(7)=0;
EOC=EOC([7 1 2 3 4 5 6]);
label=[4;8;16;32;64;128;256];
fprintf('      Mesh   Error(INF)  Error(L2)  EOC\n');



for i=1:length(error)
fprintf(' %8d %8d %8d %8d\n', label(i,:),error(i),error1(i), EOC(i));
end




h=[1/4 1/8 1/16 1/32 1/64 1/128 1/256];



loglog(h,error','*b-');
hold on;
loglog(h,h.^(2),'+k-');
grid off;



xlabel('h');
ylabel('Error');