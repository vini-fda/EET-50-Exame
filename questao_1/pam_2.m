function [pe] = pam_2(eb_n0)
    % Parametros
    Nsimb = 5000; % Número de amostras por símbolo
    Ntotal = 2 * Nsimb; % Número total de amostras
    N0 = 1.0; % Padronizamos N0=1 sem perda de generalidade
    % Fórmulas
    sigma = sqrt(N0/2.0); % PSD=N0/2
    Es = N0 * eb_n0;
    delta = 2 * sqrt(Es);

    % Monte Carlo
    ruido = sigma * randn(length(eb_n0), Nsimb);
    y0 = delta' / 2.0 + ruido;
    y1 = -delta' / 2.0 + ruido;

    Erros = sum(y0 < 0, 2)' + sum(y1 > 0, 2)';
    pe = Erros / Ntotal;
end

