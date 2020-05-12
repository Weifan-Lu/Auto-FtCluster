function [Strikeangle] = Strike(normal,zz)

%%%%求走向
       line_theta=cross(normal,zz); %% 两个法向量的法向量就是直线的方向向量
%%即已知直线l:ax+by+c=0，则直线l的方向向量为d1=(-b,a)或d2=(b,-a)。
       a=line_theta(1,2);b=-line_theta(1,1);
       k=-(a/b);
       angle1 = atan(k);
       Strikeangle = 90-(angle1*180)/pi;
end
