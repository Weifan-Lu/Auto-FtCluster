function [Dipangle, Strikeangle,SST1,DD1,z,Point] = Ftplanex1(C1)     
%%%%% Calculate the parameters of fault %%%%%%%%%
%%%% Created 2019.10  %%%%

  %%% Inputs: 
           C1:  [x,y,z] -> catalog
  %%% Outputs:
     % Dipangle -> Dip angle
     % Strikeangle -> Strike angle
     % SST1 --> RMS value
     % DD1 --> Distance (earthquake to fault plane)   Km
     % z --> equation of a surface
     % Point -->  central point ([mean_x,mean_y,mean_z])
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
         mean_x=mean(C1(:,1));
         mean_y=mean(C1(:,2));
         mean_z=mean(C1(:,3));
         Point=[mean_x mean_y mean_z];
         [COEFF latent]=prinCA(C1);
         [z,A,B,C,doubleDD] = Ftplane11(mean_x,mean_y,mean_z,COEFF);
%% Extract  coefficients: 0=ax+by+cz+d %%%%
         aa=doubleDD(1,4);
         bb=doubleDD(1,3);
         cc=doubleDD(1,2);
         dd=doubleDD(1,1);
        
         [m1 n1]=size(C1); %m - number of data，n dimensionality of data; 
         for ii=1:m1
             DD1(ii)=abs(aa*C1(ii,1)+bb*C1(ii,2)+cc*C1(ii,3)+dd)/sqrt(aa^2+bb^2+cc^2);
             DDD(ii)=(DD1(ii)).*(DD1(ii));
         end  
         DD1=DD1';
         SST1=sum(DDD);
%%%%% Calculate the parameters of fault %%%%%%%%%
         normal=cross(B-A,C-A);
         zz=[0,0,1];
         zxx=[-1,0,0];
         fz=dot(zxx,normal)
         if fz < 0 
             zz=[0,0,-1];
         end
         Dipangle=Dip(normal,zz);
         Strikeangle=Strike(normal,zz);
end
