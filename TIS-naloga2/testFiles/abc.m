
a=[1,3,5,7,2,11,13];
b=[2,4,6,8,10,12,2];
c= zeros(1,numel(a)+numel(b));
indxA=1;
indxB=1;
alter=0;
indxC=1;
len = (size(c))(2);
while(indxC<=len)
  if(alter==0)
  c(indxC)=a(indxA);
  alter = 1;
  indxC++;
  indxA++;
  else
  c(indxC)=b(indxB);
  alter = 0;
  indxC++;
  indxB++;
  endif
endwhile
g=[1,2;4,2;3,2;5,3;7,4;];
h=['0000';'0001';'0010';'0011';'0100'];
z= cell((size(g))(1),g(size(g)(1),size(g)(2)));
f=[4,1,5,3,5,7,1];
z(1,:)=[0,0];
z(2,:)=[1,0,1];
n="0";
i=1;
fin=size(f)(2);
out=[];
ls=size(h)(2);
temp=[];
while(i<=fin)
inx = find(g(:,1)==f(i));
howMuch = g(inx,2);
j=h(inx,:);
gradnik=substr(j,-howMuch);
gradnik
temp = strcat(temp,gradnik);
i++;
endwhile 
temp