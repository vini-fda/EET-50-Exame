function [pe] = qam_4_natural(eb_n0)
    % Parametros
    Nsimb = 10^5;
    ipHat = zeros(1,Nsimb);
    N0 = 1.0; % Padronizamos N0=1 sem perda de generalidade
    Es = 2 * N0 * eb_n0;
    
    Erros = zeros(1,length(Es));
    for k = 1:length(Es)
        b0 = rand(1,Nsimb)>0.5;
        b1 = rand(1,Nsimb)>0.5;
        ip_bit = b0 + 1i*b1;
        % mapeamento natural
        % 00 = -1-1j
        % 01 = +1-1j
        % 10 = +1+1j
        % 11 = -1+1j
        ip = (2*bitxor(b0,b1)-1) + 1i*(2*b0-1);
        s = (1/sqrt(2))*ip; % normalização da energia
        ruido = randn(1,Nsimb) + 1i*randn(1,Nsimb); % ruído
        delta = sqrt(2*Es(k));
        
        y = s + (1/delta) * ruido; % AWGN
        
        % demodulação
        y_re = real(y);
        y_im = imag(y);
        ipHat(y_re < 0 & y_im < 0) = 0;      % 00;
        ipHat(y_re >= 0 & y_im > 0) = 1;     % 10;
        ipHat(y_re < 0 & y_im >= 0) = 1 + 1i;% 11;
        ipHat(y_re >= 0 & y_im < 0) = 1i;    % 01;
        
        % Contagem dos erros de bit para cada valor de eb/n0
        diff = ip_bit - ipHat;
        Erros(k) = sum(abs(real(diff)) + abs(imag(diff)));
    end
    pe = Erros / (2*Nsimb);
end



