function izhod = naloga4(vhod,Fs)
% Funkcija naloga4 skusa poiskati akord v zvocnem zapisu.
%
% vhod  - vhodni zvocni zapis (vrsticni vektor tipa double) 
% Fs    - frekvenca vzorcenja
% izhod - ime akorda, ki se skriva v zvocnem zapisu (niz);
%         ce frekvence v zvocnem zapisu ne ustrezajo nobenemu
%         od navedenih akordov, vrnemo prazen niz [].
result = [];
limit = 0.1;
Delta = length(vhod)/Fs;
x = fft(vhod);
p = (abs(x).^2)/length(x);
akordi = [262,330,392;
          262,311,392;
          294,370,440;
          294,349,440;
          330,415,494;
          330,392,494;
          349,440,523;
          349,415,523;
          392,494,587;
          392,466,587;
          440,554,659;
          440,523,659;
          494,622,740;
          494,587,740];
imena = ["Cdur";
         "Cmol";
         "Ddur";
         "Dmol";
         "Edur";
         "Emol";
         "Fdur";
         "Fmol";
         "Gdur";
         "Gmol";
         "Adur";
         "Amol";
         "Hdur";
         "Hmol"];
confirm = 0;         
for i = 1:14
  for j = 1:3
    Hz = akordi(i,j);
    if((p(1,round(Hz*Delta)-1) > limit) || (p(1,round(Hz*Delta)) > limit) || (p(1,round(Hz*Delta)+1) > limit))
     confirm = confirm + 1;   
    end
  end
    if(confirm == 3)
      result = imena(i,:);
      break;
    end
    confirm = 0;
end
izhod = result