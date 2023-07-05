function [pe] = pam_4(eb_n0)
    % Parametros
    Nsimb = 5000; % Número de amostras por símbolo
    Ntotal = 4 * Nsimb; % Número total de amostras
    N0 = 1.0; % Padronizamos N0=1 sem perda de generalidade
    % Fórmulas
    sigma = sqrt(N0/2.0); % PSD=N0/2
    Es = 2 * N0 * eb_n0;
    delta = 2 * sqrt(3*Es/15)';

    % Monte Carlo
    ruido = sigma * randn(length(eb_n0), Nsimb);
    y0 = -3*delta / 2.0 + ruido;
    y1 = -delta / 2.0 + ruido;
    y2 = delta / 2.0 + ruido;
    y3 = 3*delta / 2.0 + ruido;

    Erros = sum(y0 > -delta, 2) + sum(y3 < delta, 2) + ...
        sum(y1 < -delta | y1 > 0, 2) + sum(y2 > delta | y2 < 0, 2);
    pe = Erros' / Ntotal;
end

