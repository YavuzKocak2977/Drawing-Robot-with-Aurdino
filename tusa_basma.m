function tusa_basma(~, event)
    global cizim kirmizi_cizginin_disi programdan_cikma;
    if strcmp(event.Key, 'k')
        cizim = true;
        kirmizi_cizginin_disi = false; 
    elseif strcmp(event.Key, 'escape')
        programdan_cikma = true;
    end
end
