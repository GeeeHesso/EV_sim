vitesseLimit2 = vitesseLimit

for k=1:1:length(vitesseLimit)
    
    
    
    if vitesseLimit(k) < (30/3.6)
        vitesseLimit(k) = 30/3.6;
    elseif vitesseLimit(k) >= (30/3.6) && vitesseLimit(k)<(50/3.6)
        vitesseLimit(k) = 50/3.6;
    elseif vitesseLimit(k) >= (50/3.6) && vitesseLimit(k)<(80/3.6)
        vitesseLimit(k) = 80/3.6;
    elseif vitesseLimit(k) >= (80/3.6)
        vitesseLimit(k) = 120/3.6;
    end
    
end