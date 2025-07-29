clc;
clear;

ard = arduino('COM6', 'Uno'); %%% BU ADIM ÇOK ÖNEMLİ AURDİNOYU BİLGİSAYARA TAK SONRA İŞLEMLER BAŞLIYACAK!!!!
ser1= servo(ard, 'D9'); %%% Base servo
ser2 = servo(ard, 'D10'); %%% Bu ortadaki servo
ser3 = servo(ard, 'D12'); %%% En uçtaki servo

import java.awt.Robot;
import java.awt.event.*;
robot = Robot();

y_kagid = 340.98197063;
x_kagid = 253.98197063;
t_1 = input('Saniyede kaç nokta atmak istiyorsun? (Max 200 (-) , Min 0 (+) girebilirsin. )'); %200 destekliyor ama kesinlikle tavsiye etmiyorum

while t_1 >= 201|| t_1 <= 0
    disp('100 den büyük veya 0 dan küçük bir değer girdin.');
    disp('TEKRARDAN DEĞER GİR!!');
    t_1 = input('Saniyede kaç nokta atmak istiyorsun? (Max 100, Min 1 girebilirsin.) ');
end

delay = 1 / (t_1*1.1);

figure('Units', 'normalized', 'Position', [0.1, 0.1, 1 ,1], 'ToolBar', 'none', 'WindowState', 'maximized');
axis equal; % Ölçek oranını eşit tutar


xlim([0, x_kagid]);
xlabel('Kağıdın X ekseni **mm** cinsinden yazıldı');
ylim([0, y_kagid]);
ylabel('Kağıdın Y ekseni **mm** cinsinden yazıldı');
axis([0 x_kagid 0 y_kagid]);

xticks(0:10:x_kagid);
yticks(0:10:y_kagid);
rectangle('Position', [53.981970629999999, 53.981970629999999, 190, 277], 'LineStyle', '--', 'EdgeColor', 'r');
text(10, -25, 'KIRMIZI ÇİZGİNİN DIŞINA ÇIKMA', 'Color', 'r');
hold on;
grid on;
grid minor;

x_guvenlik = [0 53.98197063];
y_guvenlik = [0 53.98197063];
plot(x_guvenlik, y_guvenlik, '--g');
text(10, -35, '10mm X ve Y eksenine güvenlik çizgisi bırakıldı', 'Color', 'g');

global cizim kirmizi_cizginin_disi programdan_cikma nokta_matrisi_k nokta_matrisi_y satir matrisler;
cizim = false;
kirmizi_cizginin_disi = false;
programdan_cikma = false;
nokta_matrisi_k = []; %şu an için sadece kırmızı nokta koyduğundan bu matrise kaydedilecek, işlemler bu matris üzerinden yapılmaktadır.
nokta_matrisi_y = []; % ilerde değişik noktalar eklemek istersem diye var bu
satir = 1;
matrisler = {}; % daha sonra veriler buradan çekilecek yani sırayla matrisler{1} {2} diye devam edecek

set(gcf, 'KeyPressFcn', @tusa_basma, 'KeyReleaseFcn', @tustan_cekme);

disp('Kırmızı noktalar girilmeye başlanıyor');
while ~programdan_cikma
    if cizim && ~kirmizi_cizginin_disi
        mouseun_konumu = get(gca, 'CurrentPoint');
        x = round(mouseun_konumu(1, 1),5);  %5 den fazla girince program yavaşlıyor eğer kaldırıcaksan saniyede maks 30 filan nokta koysun
        y = round(mouseun_konumu(1, 2),5);

        if  x< 53.98197063 || x > (53.98197063 + 190) || y < 53.98197063 || y > (53.98197063 + 277)
            kirmizi_cizginin_disi = true;
            disp('Kırmızı çizginin dışına çıktın! Tekrardan grafiğe sol tıkla ve  "k" tuşuna basarak ve çizmeye devam et.');
        else
            plot(x, y, 'r.');
            robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);
            robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);
            nokta_matrisi_k(satir, :) = [satir, x, y];
            satir = satir + 1;

            pause(delay);
        end
    end
    pause(0.0001);
end

disp('Kaydedilen Noktalar:');

for i = 1:length(matrisler)
    disp(['Matris ', num2str(i), ':']);
    disp(array2table(matrisler{i}, 'VariableNames', {'Satır', 'X', 'Y'}));
end

disp('Program sonlandı.');

teta1 = cell(length(matrisler), 1);
teta2 = cell(length(matrisler), 1);

for i = 1:length(matrisler)
    isleme_alinan_matris = matrisler{i};
    [matris_satir_sayisi, ~] = size(isleme_alinan_matris);
    
    teta1_gecici = zeros(matris_satir_sayisi, 1);
    teta2_gecici = zeros(matris_satir_sayisi, 1);
    
    for m = 1:matris_satir_sayisi
        x_sutunu = 2;
        y_sutunu = 3;
        x_0_3 = isleme_alinan_matris(m, x_sutunu);
        y_0_3 = isleme_alinan_matris(m, y_sutunu);
        
        r = sqrt(x_0_3^2 + y_0_3^2); 
        teta_1 = atan2d(y_0_3, x_0_3) - acosd((225^2 - r^2 - 225^2) / (-2 * r * 225));
        teta_2 = 180 - acosd((r^2 - 225^2 - 225^2) / (-2 * 225 * 225));
        
        teta1_gecici(m) = teta_1+60; %%%%%%%%%%%% BURASI ÇOK ÖNEMLİ  BİZ KOLU İLK SIFIRLAMAK İÇİN 60 DERECEYE GETİRİYORUZ
        teta2_gecici(m) = teta_2;
    end
    
    teta1{i} = teta1_gecici;
    teta2{i} = teta2_gecici;
end

disp('Teta1 ve Teta2 açılarını Workspace den okuyabilirsiniz. Bu ksım için çok büyük olduklarından yazılmayacak.');


teta1_arduinp_kullanilacak = cell(length(teta1), 1);
teta2_arduinp_kullanilacak = cell(length(teta2), 1);

for f = 1:length(teta1)
    islem_teta1 = teta1{f};
    islem_teta2 = teta2{f};
    
    teta1_hesap_arduino2 = zeros(length(islem_teta1), 1);
    teta2_hesap_arduino2 = zeros(length(islem_teta2), 1);

    for k = 1:length(teta1{f})
        teta1_hesap_arduino = (teta1{f}(k)) / 180;
        teta2_hesap_arduino = (teta2{f}(k)) / 180;

        teta1_hesap_arduino2(k) = teta1_hesap_arduino;
        teta2_hesap_arduino2(k) = teta2_hesap_arduino;
    end

    teta1_arduinp_kullanilacak{f} = teta1_hesap_arduino2;
    teta2_arduinp_kullanilacak{f} = teta2_hesap_arduino2;
end

%%% Bu kısım nedenini anlamadığım şekilde bazen yerine gitmemesinden
%%% kaynaklanıyor,  olması gereken açı değerleri daha sonradan girilecek

writePosition(ser3, 0.0556); %%%    Kalemi yukarı kaldırma açısı 10 derece seçildi
writePosition(ser1, 0.333); %%% Servo birie 60 derece faz verildi, çalışma alanınn içer,sine çıkmaması için 60 derece bekleyecek şekilde seçtik
writePosition(ser2, 0.5); %%% servo2 
pause(1);

writePosition(ser3, 0.0556);
writePosition(ser1, 0.333);
writePosition(ser2, 0.5);
pause(1);


for a=1:length(teta1_arduinp_kullanilacak)

    writePosition(ser3, 0.0556); % kaldırma komutu
    for n=1:length(teta1_arduinp_kullanilacak{a})

        writePosition(ser1, teta1_arduinp_kullanilacak{a}(n));  %burada servo 1 açı değerlerini alıp hareket ediyo
        writePosition(ser2, teta2_arduinp_kullanilacak{a}(n)); % aynısı burada da geçerli
        pause(0.15);

        if n == 1
            pause(2)
            writePosition(ser3, 0.3333); % Kalem aşağı indirme açısı 55 olarak seçmiştik
            
        end

    end

    writePosition(ser3, 0.0556); % kaldırma komutu
    pause(0.1)

end

disp('Çizim bitti')
