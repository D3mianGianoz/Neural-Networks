function [A,B,R,err,c]=retropro(Inp,Targ,nhid,Eta,Err,Nmax,seme);
%
tic
%
[N,n]=size(Inp); %numero colonne e numero di righe
[N1,z]=size(Targ);

if N~=N1 
fprintf('Dimensionamento non corretto\n\n');
% break;
end

%Inizializzazione random dei pesi
rand('state',seme);
A=2*(rand(nhid,n)-0.5*ones(nhid,n));
B=2*(rand(z,nhid)-0.5*ones(z,nhid));

Inp=Inp';
Targ=Targ';
Nd=N*z;
err=[];

c=0;
ciclo=0;

while ciclo==0
    % passo in avanti (somma pesata)
    % R è l'output del neurone hidden giusto
    R=f(B*f(A*Inp));   
    % q errore quadratico medio, laboratorio matriciale.
    % matrice tattiche = sommatoria prodotto tra due vettori
    % (R-Targ) è l'errore sul neurone
    % divisone per Nd
	q=ones(1,z)*((R-Targ).^2)*ones(N,1)/Nd; 
        err=[err q];

	if q<=Err || c>=Nmax
		ciclo=1;
	end
	
	if ciclo==0
		c=c+1;
		for k=1:N
			%
			% Modifica di A e B.
			% valore di uscita dei valori input
			Yhid=f(A*Inp(:,k)); %passo in avanti (somma pesata)
			Out=f(B*Yhid); 
            % derivata della funzione sigmoidale .*Out.*(1-Out)
			DOut=(Targ(:,k)-Out).*Out.*(1-Out); % delta relativo all'uscita/calcolo del segnale d'errore dell'output ETA = 1 (learning rate)
            % Calcolo l'errore
			E=DOut'*B;
            % Aggiorno i pesi B
            B=B+DOut*Yhid';
            % E' => Erore cumulativo del livello successivo
			DYhid=Eta*E'.*Yhid.*(1-Yhid); % delta hidden (segnale d'errore)
            % Aggiorno i pesi A 
			A=A+DYhid*Inp(:,k)';
			%
		end
	end
end
R=R';
