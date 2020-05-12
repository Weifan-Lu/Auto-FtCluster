function [V,D]=prinCA(X)
         [m,n]=size(X); 
         mv=mean(X); %计算各变量的均值
         st=std(X); %计算各变量的标准差
         X=X-repmat(mv,m,1);
         R=cov(X);     
         [V,D]=eig(R);       %计算矩阵R的特征向量矩阵V和特征值矩阵D,特征值由小到大
end
