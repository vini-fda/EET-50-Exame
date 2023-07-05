function [ser_coerente, ser_nao_coerente] = fsk_2(eb_n0)
    Nsimb = 5000;
    for i=1:length(eb_n0)
        sigma = sqrt(1 / (2.0 * eb_n0(i)));
        x = sigma * (randn(Nsimb, 2) + 1i * randn(Nsimb, 2));
        x(:, 1) = x(:, 1) + 1;
        [~, coherent_detect] = max(real(x), [], 2);
        [~, noncoherent_detect] = max(abs(x), [], 2);
        ser_coerente(i) = mean(coherent_detect ~= 1);
        ser_nao_coerente(i) = mean(noncoherent_detect ~= 1);
    end
end

% function [ser_coerente, ser_nao_coerente] = fsk_2(eb_n0)
%     Nsimb = 5000;
%     sigma = sqrt(1 / (2.0 * eb_n0));
%     x = sigma * (randn(Nsimb, 2) + 1i * randn(Nsimb, 2));
%     x(:, 1) = x(:, 1) + 1;
%     [~, coherent_detect] = max(real(x), [], 2);
%     [~, noncoherent_detect] = max(abs(x), [], 2);
%     ser_coerente = mean(coherent_detect ~= 0);
%     ser_nao_coerente = mean(noncoherent_detect ~= 0);
% end
