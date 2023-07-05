function [pe] = m_qam(eb_n0, m)
    % Parametros
    Nsimb = 10^4;
    ipHat = zeros(1,Nsimb);
    es_n0 = log2(m) * eb_n0;
    l = sqrt(m);
    
    Erros = zeros(1, length(es_n0));
    for k = 1:length(es_n0)
        ip = 2*randi(l, 1, Nsimb) - (l+1) + 1i*(2*randi(l, 1, Nsimb) - (l+1));
        ruido = randn(1,Nsimb) + 1i*randn(1,Nsimb); % ruído
        delta = sqrt(6*es_n0(k)/(m-1));
        
        y = ip + (sqrt(2)/delta) * ruido; % AWGN
        
        % demodulação
        ipHat_re = 2*max(0, min(l-1, round(0.5*real(y) + (l-1)/2.0))) - (l-1);
        ipHat_im = 2*max(0, min(l-1, round(0.5*imag(y) + (l-1)/2.0))) - (l-1);
        ipHat = ipHat_re + 1i*ipHat_im;

        diff = (ip - ipHat)/2;
        
        % Contagem dos erros para cada valor de eb/n0
        Erros(k) = sum(abs(real(diff)) + abs(imag(diff)));
    end
    pe = Erros / (log2(m) * Nsimb);
end