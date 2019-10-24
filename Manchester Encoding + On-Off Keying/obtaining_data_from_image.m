img = imread('lines.jpg');
disp(img);
% now we will demodulate and decode the image

bits = zeros(1, 256); % stores extracted bits

for n = 31 : (256 - 30)
    Sum = uint32(0);
    for m = 1 : 64
        Sum = Sum + uint32(img(m, n));
    end
    % disp(Sum);
    if Sum > 8128
        bits(n) = 1;
    end
end

%disp('bits');
%disp(bits);
decodedBits = ones(1, 128);  % after extracting the bits (demodulating)
                              % we'll do the reverse of Manchester encoding
                              % to get the actual transmitted bits.

n = 31;

for i = 1 : 11 * 8
    if ((bits(n) == 0) && (bits(n + 1) == 1))
        decodedBits(i) = 0;
    end
    n = n + 2;
end

disp('decoded bits');
% disp(decodedBits);
% extract 8 bit ASCII characters, store in a string and display

final_str = '';

% disp(decodedBits);

for i = 1 : 11
    submatrix = decodedBits(((i - 1) * 8) + 1: i * 8);
    % disp(submatrix);
    str_x = num2str(submatrix);
    y = bin2dec(str_x);
    %disp(y);
    final_str = append(final_str, char(y));
end

disp(final_str);