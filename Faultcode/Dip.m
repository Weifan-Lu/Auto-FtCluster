function [Dipangle] = Dip(normal,zz)

%%%%求角
      theta=acos(dot(normal,zz)/(norm(normal)*norm(zz)));
      Dipangle=(theta*180)/pi;
end
