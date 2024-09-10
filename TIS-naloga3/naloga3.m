function [izhod, crc] = naloga3(vhod, n, k)
% Izvedemo dekodiranje binarnega niza vhod, ki je bilo
% zakodirano s Hammingovim kodom H(n,k)
% in poslano po zasumljenem kanalu.
% Nad vhodom izracunamo vrednost crc po standardu CRC-8-CITT.
%
% vhod  - binarni vektor y (vrstica tipa double)
% n     - stevilo bitov v kodni zamenjavi
% k     - stevilo podatkovnih bitov v kodni zamenjavi
% crc   - crc vrednost izracunana po CRC-8-CITT 
%         nad vhodnim vektorjem (sestnajstisko)
% izhod - vektor podatkovnih bitov, dekodiranih iz vhoda

m = n-k;
h = 1:n;
H = fliplr(dec2bin((h)))';
tmp1 = n; 
tmp2 = 0; 
D=[];
izhod = [];
for i = 1:m
p = pow2(tmp2);
I = H(:,p);
i = h(p);
D = [D p];
H = [H I];
h = [h i];
tmp1 = tmp1 - 1; 
tmp2 = tmp2 + 1; 
endfor
H(:,D) = [];
h(D) = [];
t = length(vhod)/n;
zacetek = 1;
konec = n;
for i = 1:t
tmp = vhod(zacetek:konec);
s = bin2dec(int2str(fliplr(mod(tmp*H',2))));
if(s != 0 )
 index = find(h == s);
 tmp(index) = mod(tmp(index)+1,2);
 izhod =[izhod tmp(1:k)]; 
else
 izhod =[izhod tmp(1:k)];
endif
zacetek = zacetek + n;
konec = konec + n;
endfor
y=vhod;
l = length(vhod);
i=1;
register = zeros(1,8)';
while (i <= l)
pm = mod(register(8)+y(i),2);
register(8) = register(7);
register(7) = register(6);
register(6) = register(5);
register(5) = register(4);
register(4) = register(3);
register(3) = register(2);
register(2) = register(1);
register([2 3]) = mod(register([2 3])+pm,2);
register(1) = pm;
i++;
endwhile
crc = dec2hex(bin2dec(int2str(fliplr(register'))));
end
