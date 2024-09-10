% Funkcija za preverjanje naloge 1.
% Primer zagona:
% test_naloga1('primeri',1);

function success = test_naloga1(caseDir,caseID)
	
  	% Zahtevana natancnost rezultata
	tol = 1e-3;
  
	% Nalozi vhodne podatke in resitev
	caseData = load([caseDir,filesep,num2str(caseID),'.mat']);
	
	% Preberi program
	fileProgram = 'naloga1.m';
	source(fileProgram);
	% Ce zelimo imeti vec funkcij v datoteki, na zacetek datoteke napisemo npr.:
    % 1;
    % da s tem povemo, da gre za skriptno datoteko. 
    % Dobimo sicer opozorilo, ki je posledica dejstva, da sta ime funkcije 
    % naloga1 in ime skriptne datoteke enaka. Se ne sekiramo.
	
	% Pozeni 
	tic();
	[H, R] = naloga1(caseData.besedilo,caseData.p);
	timeElapsed = toc();
	
  	% Preveri rezultate
	success = (abs(H - caseData.H) < tol) & (abs(R - caseData.R) < tol);
	
	printf('Rezultat za primer %d: %d\n',caseID,success);
  	printf('Cas izvajanja: %f sekund.\n',timeElapsed);

end
