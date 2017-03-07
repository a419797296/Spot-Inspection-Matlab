v=[3 3.45 3.68 3.74 3.77 3.79 3.82 3.87 3.92 3.98 4.06 4.2]*1000
per=[0 5 10 20 30 40 50 60 70 80 90 100]
plot(v,per)
p=polyfit(v(4:end),per(4:end),2)
x=3.74:0.02:4.2;
x=x*1000;
y=polyval(p,x);
hold on
plot(x,y,'r')

p1=polyfit(v(1:4),per(1:4),1)
x1=3:0.02:3.74;
x1=x1*1000;
y1=polyval(p1,x1);
hold on
plot(x1,y1,'k')