function [xv yv zv V D L W]= planepoint1(X)
   
    k=1;
    [V,D]=prinCA(X);
   
    W=sqrt(6.*D(3,3));
    L=sqrt(12.*D(2,2));
    
    L2=L/2;
    W2=W/2;
    xb=mean(X(:,1));
    yb=mean(X(:,2));
    zb=mean(X(:,3));
    
    xv(k,1)=W2.*V(1,2)+L2.*V(1,3) + xb(k);
    yv(k,1)=W2.*V(2,2)+L2.*V(2,3) + yb(k);
    zv(k,1)=W2.*V(3,2)+L2.*V(3,3) + zb(k);

    xv(k,2)=W2.*V(1,2)-L2.*V(1,3) + xb(k);
    yv(k,2)=W2.*V(2,2)-L2.*V(2,3) + yb(k);
    zv(k,2)=W2.*V(3,2)-L2.*V(3,3) + zb(k);

    xv(k,3)=-W2.*V(1,2)-L2.*V(1,3) + xb(k);
    yv(k,3)=-W2.*V(2,2)-L2.*V(2,3) + yb(k);
    zv(k,3)=-W2.*V(3,2)-L2.*V(3,3) + zb(k);

    xv(k,4)=-W2.*V(1,2)+L2.*V(1,3) + xb(k);
    yv(k,4)=-W2.*V(2,2)+L2.*V(2,3) + yb(k);
    zv(k,4)=-W2.*V(3,2)+L2.*V(3,3) + zb(k);
    
end
