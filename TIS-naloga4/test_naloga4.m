% Funkcija za preverjanje naloge 4.
% Primer zagona:
% test_naloga4('primeri',1);

function success = test_naloga4(caseDir,caseID)
			
	% Nalozi vhodne podatke in resitev
	caseData = load([caseDir,filesep,num2str(caseID),'.mat']);
	
	% Pozeni 
	tic();
	[izhod] = naloga4(caseData.vhod, caseData.Fs);
	timeElapsed = toc();
	
	% Preveri rezultate
	fprintf('Rezultat za primer %d\n',caseID);
	fprintf('-----------------------------\n');
	success = strcmpi(izhod, caseData.izhod);
	fprintf('Uspeh: %d\n',success);	
	fprintf('Cas izvajanja: %f sekund.\n',timeElapsed);
  	fprintf('-----------------------------\n');

end
