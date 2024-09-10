% Funkcija za preverjanje naloge 3.
% Primer zagona:
% test_naloga3('primeri',1);

function success = test_naloga3(caseDir,caseID)
	  
	% Nalozi vhodne podatke in resitev
	caseData = load([caseDir,filesep,num2str(caseID),'.mat']);
	
	% Preberi program
	fileProgram = 'naloga3.m';
	source(fileProgram);
	
	% Pozeni 
	tic();
	[izhod, crc] = naloga3(caseData.vhod, caseData.n, caseData.k);
	timeElapsed = toc();
	
	% Preveri rezultate
	success1 = isequal(izhod(:), caseData.izhod(:));
    success2 = isequal(upper(crc(:)), caseData.crc(:));
	success = success1 * 0.5 + success2 * 0.5;
    
	printf('Rezultat za primer %d\n',caseID);
	printf('-----------------------------\n');	
	printf('St. tock: %d\n',success);
	printf('Cas izvajanja: %f sekund.\n',timeElapsed);
  	printf('-----------------------------\n');

end
