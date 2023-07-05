function [pe] = qam_4(eb_n0)
    % Parametros
    Nsimb = 10^5;
    ipHat = zeros(1,Nsimb);
    N0 = 1.0; % Padronizamos N0=1 sem perda de generalidade
    Es = 2 * N0 * eb_n0;
    
    Erros = zeros(length(Es));
    for k = 1:length(Es)
        ip = (2*(rand(1,Nsimb)>0.5)-1) + 1i*(2*(rand(1,Nsimb)>0.5)-1);
        s = (1/sqrt(2))*ip; % normalização da energia
        ruido = randn(1,Nsimb) + 1i*randn(1,Nsimb); % ruído
        delta = sqrt(2*Es(k));
        
        y = s + (1/delta) * ruido; % AWGN
        
        % demodulação
        y_re = real(y);
        y_im = imag(y);
        ipHat(y_re < 0 & y_im < 0) = -1 + -1i;
        ipHat(y_re >= 0 & y_im > 0) = 1 + 1i;
        ipHat(y_re < 0 & y_im >= 0) = -1 + 1i;
        ipHat(y_re >= 0 & y_im < 0) = 1 - 1i;
        
        % Contagem dos erros para cada valor de eb/n0
        Erros(k) = size(find(ip - ipHat),2);
    end
    pe = Erros / Nsimb;
end



%simSer_QPSK = nErr/N;
%theorySer_QPSK = erfc(sqrt(0.5*(10.^(Es_N0_dB/10)))) - (1/4)*(erfc(sqrt(0.5*(10.^(Es_N0_dB/10))))).^2;

% close all
% figure
% semilogy(Es_N0_dB,theorySer_QPSK,'b.-');
% hold on
% semilogy(Es_N0_dB,simSer_QPSK,'mx-');
% axis([-3 15 10^-5 1])
% grid on
% legend('theory-QPSK', 'simulation-QPSK');
% xlabel('Es/No, dB')
% ylabel('Symbol Error Rate')
% title('Symbol error probability curve for QPSK(4-QAM)')



