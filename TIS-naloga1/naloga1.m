function [H,R] = naloga1(besedilo,p)
% besedilo - stolpicni vektor znakov (char)
% p  - stevilo poznanih predhodnih znakov; 0, 1, 2 ali 3.
%    p = 0 pomeni, da racunamo povprecno informacijo na znak
%        abecede brez poznanih predhodnih znakov: H(X1)
%    p = 1 pomeni, da racunamo povprecno informacijo na znak 
%        abecede pri enem poznanem predhodnemu znaku: H(X2|X1)
%    p = 2: H(X3|X1,X2)
%    p = 3: H(X4|X1,X2,X3)
%
% H - skalar; povprecna informacija na znak abecede 
%     z upostevanjem stevila poznanih predhodnih znakov p
% R - skalar; redundanca znaka abecede z upostevanjem 
%     stevila poznanih predhodnih znakov p

 besedilo = double(upper(besedilo(isalnum(besedilo)))); 
 dolzinaBesedila = numel(besedilo);
 unikatniZnaki = unique(besedilo);
 stUnikatov = numel(unikatniZnaki);

 pojavitve1 = histc(besedilo,unikatniZnaki);
 verjetnost1 = pojavitve1/dolzinaBesedila;  
 H1= - sum(verjetnost1.*log2(verjetnost1)); %H(X1);
 
 if(p==0)
   H = H1;
   R = 1-(H/(log2(stUnikatov)));  
 
 else
   T1 = besedilo;
   T2 = circshift(T1,-1);
   pari = [T1,T2];
   [U,I,J] = unique(pari,"rows");
   edges2 = 1: length(I);
   pojavitve2 = histc(J,edges2);
   verjetnost2 = pojavitve2/dolzinaBesedila;
   H2 = -(verjetnost2')*log2(verjetnost2);  %H(X2,X1)
      
      if(p==1)
        H = H2 - H1;
        R = 1-(H/(log2(stUnikatov)));
      
      else
        T3 = circshift(T1,-2);
        trojice = [pari,T3]; 
        [U,I,J] = unique(trojice,"rows");
        edges3 = 1: length(I);
        pojavitve3 = histc(J,edges3);
        verjetnost3 = pojavitve3/dolzinaBesedila;
        H3 = -(verjetnost3')*log2(verjetnost3); %H(X3,X2,X1) 
        
           if(p==2)
            H = H3 - H2;
            R = 1-(H/(log2(stUnikatov)));
              
           else
             T4 = circshift(T1,-3);
             stirice = [trojice,T4];
             [U,I,J] = unique(stirice,"rows");
             edges4 = 1: length(I);
             pojavitve4 = histc(J,edges4);
             verjetnost4 = pojavitve4/dolzinaBesedila;
             H4 = -(verjetnost4')*log2(verjetnost4); %H(X4,X3,X2,X1) 
             H = H4-H3;
             R = 1-(H/(log2(stUnikatov)));
           endif
      endif       
 endif
 
end

