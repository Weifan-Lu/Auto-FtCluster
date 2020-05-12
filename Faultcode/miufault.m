function [miuF,FPMS,PNplane,COEFF,latent,Nfmssdx,Point2,Point3]=miufault(C1,Clugmt)
%%% Inputs:
     % C1 --> cluster  [x,y,z] 
     % Clugmt --> FMcluster []
%%% Outputs:
     % miuF --> 
     % FPMS -->
     % PNplane -->
     %


%%%C1-cluster_d    
         mean_x=mean(C1(:,1));
         mean_y=mean(C1(:,2));
         mean_z=mean(C1(:,3));
         [COEFF latent]=prinCA(C1);
         ax=mean_x-1;
         PNplane=-[COEFF(1,1),COEFF(2,1),COEFF(3,1)]
      %   PNplane=[(mean_x+COEFF(1,1)),(mean_y+COEFF(2,1)),(mean_z+COEFF(3,1))];
         Point1=[mean_x mean_y mean_z]; %%%第一个点
         FMS=[]; 
         fPMS=[];
         Nfmssdx=[];
        if length(Clugmt(:,1)) == 1
            Clugmt=[Clugmt;Clugmt];
        end        
        for i=1:1:length(Clugmt(:,1))         
          fmsstrike=[Clugmt(i,3) Clugmt(i,6)];
          fmsdip=[Clugmt(i,4) Clugmt(i,7)];
          dpp=[];

          for ii=1:1:2              
               angle=fmsstrike(ii);fmsdip1=fmsdip(ii); 
               if fmsdip1 == 90
                   fmsdip1=50;
               end
               fmsdip1
               if angle < 180
                   theta=(90-angle)/180*pi;
                   k1=tan(theta);  
               elseif angle < 180 && angle >90
                   theta=(90+(180-angle))/180*pi;
                   k1=tan(theta);  
               elseif angle > 180 && angle < 270
                   theta=((90-(angle-180))/360)*2*pi;  
                   k1=tan(theta); 
               else  angle > 270
                  theta=((180-(angle-270))/360)*2*pi;  
                  k1=tan(theta);  
               end                        
               b1=mean_y-k1*mean_x;
               x2=ax;
               y2=k1*x2+b1;      
               Point2=[x2 y2 mean_z];  %%%第二个点
               
               k2=-(1/k1);
               b2=mean_y-k2*mean_x;
               y3=k2*x2+b2; 
               
               dd=sqrt((mean_x-x2).^2+(mean_y-y3).^2);
               theta2=fmsdip1/360*2*pi;
               hh=dd*tan(theta2);

               z3=mean_z-hh;

               Point3=[x2 y3 z3];  %%%第三个点
             
               P1P2=[Point2(1)-Point1(1) Point2(2)-Point1(2) Point2(3)-Point1(3)];
               P1P3=[Point3(1)-Point1(1) Point3(2)-Point1(2) Point3(3)-Point1(3)];
               P0x=P1P2(2)*P1P3(3)-P1P3(2)*P1P2(3);
               P0y=P1P2(3)*P1P3(1)-P1P3(3)*P1P2(1);
               P0z=P1P2(1)*P1P3(2)-P1P3(1)*P1P2(2);
               PNfms=[P0x P0y P0z]; %%震源机制面法向量 
               dp=dot(PNfms, PNplane)  %%PNplane拟合平面法向量
               if dp<0
                 PNfms=[-P0x -P0y -P0z];
                 dp=-dp;
               else
                 dp=dp;
               end
               dpp=[dpp dp]
               FMS=[FMS;PNfms];
          end        
      %    MedianStrike=abs(160-Clugmt(i,3));
          if dpp(1) > dpp(2) || Clugmt(i,6) > 300
             PFMS=FMS(1,:);
             Nnumber=1
             Nfmssd=[Clugmt(i,3) Clugmt(i,4)]
          else
             PFMS=FMS(2,:); 
             Number=2
             Nfmssd=[Clugmt(i,6) Clugmt(i,7)]
          end
          Nfmssdx=[Nfmssdx;Nfmssd];
          fPMS=[fPMS;PFMS];
          
        end
        FPMS=mean(fPMS);
        miuF=acos(dot(FPMS,PNplane)/(norm(FPMS)*norm(PNplane)));
        miuF=miuF*180/pi;   
end
