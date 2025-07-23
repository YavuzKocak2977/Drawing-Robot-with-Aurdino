function tustan_cekme(~, event)
    global cizim nokta_matrisi_k matrisler satir;
    if strcmp(event.Key, 'k')
        cizim = false;
        if ~isempty(nokta_matrisi_k)
            matrisler{end + 1} = nokta_matrisi_k;
            nokta_matrisi_k = [];
            satir = 1;
        end
    end
end