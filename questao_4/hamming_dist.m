function d = hamming_dist(a, b)
    bin_a = dec2bin(a);
    bin_b = dec2bin(b);
    
    d = sum(bin_a ~= bin_b);
end