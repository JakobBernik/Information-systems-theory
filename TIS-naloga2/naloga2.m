function [izhod, R, kodBela, kodCrna] = naloga2(vhod)
% Izvedemo kodiranje vhodne binarne slike (matrike) vhod
% po modificiranem standardu ITU-T T.4.
% Slika vsebuje poljubno stevilo vrstic in 1728 stolpcev.
%
% vhod     - matrika, ki predstavlja sliko
% izhod    - binarni vrsticni vektor
% R        - kompresijsko razmerje
% kodBela  - matrika dolzin zaporedij belih slikovnih tock
%		     in dolzin kodnih zamenjav
% kodCrna  - matrika dolzin zaporedij crnih slikovnih tock
%		     in dolzin kodnih zamenjav
 velikost = size(vhod); % velikost(1)=st. vrstic , velikost(2)=st.stolpcev
 crne = [];
 bele = [];
 Vstevila = double(vhod); %pretvori vhod iz logicnega v numeričnega
 izgradnja = []; %ta vektor bo hranil runlength kodiran celotni vhod
  i=1; %stevec vrstic
  stikalo=0; % glede na vrednost stikala vemo ali so bele oz crne na sodih oz lihih mestih
  while (i<=velikost(1)) %sprocesira vsako vrstico posebej, loci po sodih in lihih indexih in zlepi skupaj za 1 in 0
    vrstica = runlength(Vstevila(i,:)); % izvede runlength nad celo vrstico i
    if(Vstevila(i,1) == 0) %ce se vrstica zacne z 0, belim dodaj 0
    bele = [bele, 0];
    stikalo=1;
    izgradnja=[izgradnja,0];
    else
    stikalo=0;
    endif
    if(stikalo==1) %v primeru da se vrstica zacne s crno ne potrebujemo robnega pogoja da je cela vrstica bela
     crne = [crne, vrstica(1:2:end)];
     bele = [bele, vrstica(2:2:end)];
     izgradnja=[izgradnja,vrstica];
    else
     crne = [crne, vrstica(2:2:end)];
     bele = [bele, vrstica(1:2:end)];
     izgradnja=[izgradnja,vrstica];
    endif
    i++;
  endwhile
   b=sort(bele);
   c=sort(crne);
   B=unique(b);
   C=unique(c);
   pB=runlength(b)/numel(b);
   pC=runlength(c)/numel(c);
   [pB, VredB]=sort(pB',"descend");
   [pC, VredC]=sort(pC',"descend");
   B=B(VredB)';
   C=C(VredC)';
   nicB=zeros(length(B),3);
   nicC=zeros(length(C),3);
   HuffB=[B,pB,nicB];
   HuffC=[C,pC,nicC];
########################### izgradnja matrike za dolocanje dolzin kodnih zamenjav posameznih znakov za bele  
    Matrx=HuffB;
    CurrentP=0;
     while(CurrentP < 1)
      indx=find(Matrx(:,2) == min(Matrx(:,2)));
       if(length(indx)>1)
        CurrentP = Matrx(indx(1),2)+Matrx(indx(2),2);
        Matrx(indx(1),2)=3;
        Matrx(indx(2),2)=3;
        Matrx =[Matrx;[0,CurrentP,0,indx(1),indx(2)]];
       else
        CurrentP = Matrx(indx(1),2);
        Matrx(indx(1),2)=3;
        tmp = indx;
        indx=find(Matrx(:,2) == min(Matrx(:,2)));
        CurrentP = CurrentP + Matrx(indx(1),2);
        Matrx(indx(1),2)=3;
        Matrx =[Matrx;[0,CurrentP,0,tmp(1),indx(1)]];
       endif
     endwhile
      HuffB=Matrx;
########################### izgradnja matrike za dolocanje dolzin kodnih zamenjav posameznih znakov za bele      
      Matrx=HuffC;
      CurrentP=0;
     while(CurrentP < 1)
      indx=find(Matrx(:,2) == min(Matrx(:,2)));
       if(length(indx)>1)
        CurrentP = Matrx(indx(1),2)+Matrx(indx(2),2);
        Matrx(indx(1),2)=3;
        Matrx(indx(2),2)=3;
        Matrx =[Matrx;[0,CurrentP,0,indx(1),indx(2)]];
       else
        CurrentP = Matrx(indx(1),2);
        Matrx(indx(1),2)=3;
        tmp = indx;
        indx=find(Matrx(:,2) == min(Matrx(:,2)));
        CurrentP = CurrentP + Matrx(indx(1),2);
        Matrx(indx(1),2)=3;
        Matrx =[Matrx;[0,CurrentP,0,tmp(1),indx(1)]];
       endif
     endwhile
      HuffC=Matrx;
########################### izgradnja kodBela     
    Matrix=HuffB;
    Base = length(B);
    lngth=0;
    koncaj=0;
    index = (size(Matrix))(1);
    workIndex1=Matrix(index,4);
    workIndex2=Matrix(index,5);
    sideMatrx = Matrix(1:Base,1:5);
   while(index>Base)
     if(workIndex1 <= Base)
      sideMatrx(workIndex1,3) = Matrix(index,3)+1; 
     else
      Matrix(workIndex1,3) = Matrix(index,3)+1;
     endif
     if(workIndex2 <= Base)
      sideMatrx(workIndex2,3) = Matrix(index,3)+1; 
     else
      Matrix(workIndex2,3) = Matrix(index,3)+1;
     endif
    index = index - 1;
    workIndex1=Matrix(index,4);
    workIndex2=Matrix(index,5);
   endwhile
    sideMatrx = sortrows(sideMatrx,[3 1]);
    kodBela = [sideMatrx(:,1),sideMatrx(:,3)];
########################### izgradnja kodCrna   
    Matrix=HuffC;
    Base = length(C);
    lngth=0;
    koncaj=0;
    index = (size(Matrix))(1);
    workIndex1=Matrix(index,4);
    workIndex2=Matrix(index,5);
    sideMatrx = Matrix(1:Base,1:5);
   while(index>Base)
     if(workIndex1 <= Base)
      sideMatrx(workIndex1,3) = Matrix(index,3)+1; 
     else
      Matrix(workIndex1,3) = Matrix(index,3)+1;
     endif
     if(workIndex2 <= Base)
      sideMatrx(workIndex2,3) = Matrix(index,3)+1; 
     else
      Matrix(workIndex2,3) = Matrix(index,3)+1;
     endif
    index = index - 1;
    workIndex1=Matrix(index,4);
    workIndex2=Matrix(index,5);
   endwhile
   sideMatrx = sortrows(sideMatrx,[3 1]);
   kodCrna = [sideMatrx(:,1),sideMatrx(:,3)]; 
################################## priprave za gradnjo   
      bela=kodBela;
      crna=kodCrna;
      build=izgradnja;
################################## zamenjave za bele
     kod=bela;
     lght= size(kod);
      Tkz = zeros(lght(1),1);
      i=1;
      kz=kod(1,2); %najmanjsa dolzina kz
       while(i <= lght(1))
        kzStar= kz;
        kz = kod(i,2); % dolzina kz
        if(i==1) %prva zamenjava
         Tkz(i) = 0;
        else %ostale zamenjave
          if(kzStar ~= kz)
           dif = kz-kzStar;
           Tkz(i) = (Tkz(i-1)+1)*(dif*2);
          else
           Tkz(i) = Tkz(i-1)+1;
          endif
        endif
        i++;
       endwhile 
        Tkz = dec2bin(Tkz);
        i=1;
        fin = cell(lght(1),1);
       while(i<=lght(1))
        howMuch = kod(i,2);
        tmp = substr(Tkz(i,:),-howMuch);     
        j=1;
        t= size(tmp)(2);
        replacement = [];
         while(j<=t)
          replacement =[replacement,str2double(tmp(j))];
          j++;
         endwhile
         fin(i,1)={replacement};
        i++;
       endwhile
      zamenjaveB = fin;
######################## zamenjave za crne      
      kod=crna;
      lght= size(kod);
      Tkz = zeros(lght(1),1);
      i=1;
      kz=kod(1,2); %najmanjsa dolzina kz
       while(i <= lght(1))
        kzStar= kz;
        kz = kod(i,2); % dolzina kz
        if(i==1) %prva zamenjava
         Tkz(i) = 0;
        else %ostale zamenjave
          if(kzStar ~= kz)
           dif = kz-kzStar;
           Tkz(i) = (Tkz(i-1)+1)*(dif*2);
          else
           Tkz(i) = Tkz(i-1)+1;
          endif
        endif
        i++;
       endwhile 
        Tkz = dec2bin(Tkz);
        i=1;
        fin = cell(lght(1),1);
       while(i<=lght(1))
        howMuch = kod(i,2);
        tmp = substr(Tkz(i,:),-howMuch);     
        j=1;
        t= size(tmp)(2);
        replacement = [];
         while(j<=t)
          replacement =[replacement,str2double(tmp(j))];
          j++;
         endwhile
         fin(i,1)={replacement};
        i++;
       endwhile
       zamenjaveC=fin;
############################################## gradnja izhoda     
     tillFin = size(build)(2);
     out=[];
     i=1;
     sestevek=0;
     BCchange=0;
     while(i<=tillFin)
     if(sestevek==0 && BCchange==0) % nova vrstica, gradimo iz tabele bela
     inx = find(bela(:,1)==build(i));
     gradnik = cell2mat(zamenjaveB(inx,1));
     out=[out,gradnik];
     sestevek = sestevek + bela(inx,1);
     BCchange=1;
     else %dodamo barvo ki je na vrsti
       if(BCchange==0)
        inx = find(bela(:,1)==build(i));
        gradnik = cell2mat(zamenjaveB(inx,1));
        out=[out,gradnik];
        sestevek = sestevek + bela(inx,1);
        BCchange=1;
       else
        inx = find(crna(:,1)==build(i));
        gradnik = cell2mat(zamenjaveC(inx,1));
        out=[out,gradnik];
        sestevek = sestevek + crna(inx,1);
        BCchange=0;
      endif
     endif
     if(sestevek==1728) % vrstica je dokoncana
     sestevek=0;
     BCchange=0;
     endif
     i++;
     endwhile
     izhod=out;
     R = numel(izhod)/numel(vhod);
end