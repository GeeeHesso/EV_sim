function [vlim, vlimX] = getAnticipation(c_dist_int,vlim, acc_in, acc_out)

% longueur maximum
tailleMax = length(c_dist_int);

% Création des matrices vides
slope_1_inv=zeros(tailleMax);
slope_1 = zeros(tailleMax);
slope_2=zeros(tailleMax);
slope_3=zeros(tailleMax);

% Création du freinage maximum de chaque point
for k=1:1:tailleMax
    for i=1:1:k
        slope_1_inv(k,i) = sqrt((vlim(k)^2)+2*acc_in*c_dist_int(i));
    end
    slope_1(k,1:k) = flip(slope_1_inv(k,1:k));
end

% Création de l'accélération maximum de chaque point
for k=1:1:tailleMax
    for i=k:1:tailleMax
        slope_2(k,i) = sqrt((vlim(k)^2)+2*acc_out*(c_dist_int(i)-c_dist_int(k)));
    end
end

% Transposition matrice pour les graphes
slope_1=slope_1';
slope_2=slope_2';

% Le maximum des courbes
slope_12 = max(slope_1, slope_2);

% Génération du profil complet
vlimX = vlim;
for k=1:1:tailleMax
    for i=1:1:tailleMax
        vlim(i) = min(slope_12(i,k), vlim(i));
    end
end
end