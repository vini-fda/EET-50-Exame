function [pe, mods] = adaptativo(pe_max, eb_n0)
    % Usa um protocolo de transmissão adaptativo
    % dentre 5 opções:
    % 1. BPSK
    % 2. QPSK
    % 3. 8-PSK
    % 4. 16-QAM
    % 5. 64-QAM
    %
    % Como critério de seleção, ele usa a
    % maximização da eficiência espectral para um
    % desempenho de probabilidade de erro limitante 'pe_max', 
    % fornecido como parâmetro da função.
    pe = 0;
    mods = 0;
end

