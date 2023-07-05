function [pe] = m_psk(eb_n0, m)
    % Parametros
    Nsimb = 5*10^5;
    es_n0 = log2(m) * eb_n0;
    
    Erros = zeros(1, length(es_n0));
    for k = 1:length(es_n0)
        s = randi(m, 1, Nsimb) - 1;
        x = exp(2i*pi*s/m);

        ruido = (1/sqrt(2)) * (randn(1,Nsimb) + 1i*randn(1,Nsimb)); % ruído
        d = sqrt(es_n0(k));
        
        y = x + (1/d) * ruido; % AWGN
        
        % demodulação
        theta = (m / (2*pi)) * wrapTo2Pi(angle(y)) ;
        sHat = mod(round(theta), m);
        
        % Contagem dos erros para cada valor de eb/n0
        Erros(k) = size(find(s - sHat),2);
    end
    pe = Erros / Nsimb;
end

