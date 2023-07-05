function [pe, mods] = adaptativo(pe_max, eb_n0, varargin)
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
    persistent cache
    if nargin == 3
        cache = varargin{1};
    else
        % usa um cache persistente para evitar recalcular os valores
        cache(1,:) = m_qam(eb_n0, 64);
        cache(2,:) = m_qam(eb_n0, 16);
        cache(3,:) = m_psk(eb_n0, 8);
        cache(4,:) = m_psk(eb_n0, 4);
        cache(5,:) = m_psk(eb_n0, 2);
    end

    pe = zeros(1,length(eb_n0));
  
    for i=1:length(eb_n0)
        pe(i) = cache(5,i);
        for k=1:4
            prob = cache(k,i);
            if prob < pe_max
                pe(i) = prob;
                break;
            end
        end
    end
    mods = 0;
end

