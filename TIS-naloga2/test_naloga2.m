% Funkcija za preverjanje naloge 2.
% Primer zagona:
% test_naloga2('primeri',1);

function success = test_naloga2(caseDir,caseID)
	    
    % Zahtevana natancnost rezultata
	tol = 1e-6;
  
	% Nalozi vhodne podatke in resitev
	caseData = load([caseDir,filesep,num2str(caseID),'.mat']);
	
	% Preberi program
	fileProgram = 'naloga2.m';
	source(fileProgram);
	
	% Pozeni 
	tic();
	[izhod, R, kodBela, kodCrna] = naloga2(caseData.vhod);
	timeElapsed = toc();
	
    % Preveri rezultate
    success1 = abs(R - caseData.R) < tol;
	success2 = isequal(izhod, caseData.izhod);
	success3 = isequal(kodBela, caseData.kodBela);
    success4 = isequal(kodCrna, caseData.kodCrna);
	success = success1 & success2 & success3 & success4;
	
	printf('Rezultati za primer %d.\n',caseID);
    printf('-----------------------------\n');
    printf('R:       %d\nizhod:   %d\nkodBela: %d\nkodCrna: %d\n',success1,success2,success3, success4);
    printf('-----------------------------\n');
    printf('Skupni rezultat: %d\n\n',success);
    printf('Cas izvajanja: %f sekund.\n',timeElapsed);
  
    if success1 && ~success2
        if(length(izhod) == length(caseData.izhod))
            printf('Opomba: Kodiran "izhod" ni enak resitvam, kar pa se ne pomeni nujno, da je napacen. Poskusi ga dekodirati in nato ga primerjaj z "vhod".\n');
        else
            printf('Dolzina vektorja "izhod" je napacna.\n');    
        end
    end
end
