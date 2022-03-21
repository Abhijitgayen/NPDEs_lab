clc;
clear All;
close All;

exactFn=@(x)(1+x-cos(x)-(1+(pi./2)).*sin(x));

xa=0;
xb=pi/2;

%N=input("Enter value Of n : ");
N=[20 40 60 80 100];
error=zeros;
exactval=zeros;
numval=zeros;
H=zeros;
y_0=0;
y_n=0;
for it=1:length(N)
    [y,x,h]=secon_order_que_1(N(it),xa,xb);
    H(it)=h;
    %Y=[Y_0, y_1,....y_n-1,Y_n]
    y=[y_0;y;y_n]';
    %x=x(1:length(x));
    error(it)=max(abs(y-(exactFn(x))));
end

erro_ratio=zeros;
erro_ratio(1)=0;
for it=2:length(error)-1
    erro_ratio(it)=(error(it-1)/error(it));
end
erro_ratio(it+1)=0;

fprintf("      h          N      error      ratio of error\n");
for it=1:length(N)
   fprintf("     %8f   %3d  %12s   %12s  \n",H(it),N(it),num2str(error(it)),num2str(erro_ratio(it)));
end

plot(x,y,'-Or',x,exactFn(x),'-Xg','MarkerSize',10)
legend('apprixmate','Exact value')


plot(log(x),log(y));
loglog(x,y);
semilog(x,y)
plot(log(x),y)


