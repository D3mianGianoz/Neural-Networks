load con1
% suppone caricato con1 : c'� con1 in memoria, � 2500x3

rand('state',1992) % in alternativa semi: 190, 1992, 23, 

% variabilità maggiore, distribuzione più uniforme
[a,b]=percettpatt(con1(1:1250,1:2),2*con1(1:1250,3)-1,200);

%storia (esempi) appressi
figure(1)
plot(b,'.')

[z,h]=max(b);
h; %indice del primo massimo

W=a(:,h)'; %riga dei pesi ottimale

figure(2)
hold on
for i = 1:size(con1, 1)
    if (con1(i, 3) == 0)
        plot(con1(i,1)',con1(i,2)', 'r.')
    else
        plot(con1(i,1)',con1(i,2)', 'b.')
    end
end
plot([0, 1], [W(3)/W(2), W(1)/W(2)+W(3)/W(2)], 'k-')

% classificazione dei dati di training
ris=usaperc(W,con1(1:1250,1:2));
sum(ris==2*con1(1:1250,3)-1) %numero patterns imparati
sum(ris)
% classificazione dei dati di test
ris=usaperc(W,con1(1251:2500,1:2));
sum(ris==2*con1(1251:2500,3)-1) %numero patterns classificati esattamente fra i 1250 mai visti
sum(ris)





