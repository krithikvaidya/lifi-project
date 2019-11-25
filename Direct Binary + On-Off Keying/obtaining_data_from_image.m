img = imread('lines.jpg');
% disp(img);
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

final_str = '';

% disp(decodedBits);

for i = 1 : 11
    submatrix = bits((30 + (i - 1) * 8) + 1: 30 + i * 8);
    %disp(submatrix);
    str_x = num2str(submatrix);
    y = bin2dec(str_x);
    %disp(y);
    final_str = append(final_str, char(y));
end

disp(final_str);