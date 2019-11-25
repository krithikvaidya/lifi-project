img = imread('lines.jpg');
disp(img);
% now we will demodulate and decode the image

bits = zeros(1, 1024); % stores extracted bits

for n = 31 : (1024 - 30)
    Sum = uint32(0);
    for m = 1 : 64
        Sum = Sum + uint32(img(m, n));
    end
    % disp(Sum);
    if Sum > 8128
        bits(n) = 1;
    end
end

decodedBits = ones(1, 121);

n = 31;

for i = 1 : 11 * 11
    if (bits(n + 1) == 1)
        decodedBits(i) = 0;
    else
        decodedBits(i) = 1;
    end
    
    n = n + 5;
end

disp('decoded bits');

% decoding procedure:
% calculate parities for all redundant bits.
% if parity doesn't match, set to 1.
% if match, set to 0;
% find error bit (if any) by getting the 
% decimal equivalent of the binary value

final_str = '';

% disp(decodedBits);


for i = 1 : 11
    errorBit = uint32(0);
    % store the row in seperate variable
    Hamming = decodedBits(((i - 1) * 11) + 1: i * 11);
    disp(Hamming);
    % check correctness of parities
    sum = 0;
    ctr = 0;
    
    for  j = 11 : -1 : 1
        if rem(ctr, 2) == 0
            sum = sum + Hamming(j);
        end
        ctr = ctr + 1;
    end
    
    if rem(Hamming(1) + Hamming(3) + Hamming(5) + Hamming(7) + Hamming(9) + Hamming(11), 2) == 1
        errorBit = errorBit + 1;
    end
    
    if rem(Hamming(1) + Hamming(2) + Hamming(5) + Hamming(6) + Hamming(9) + Hamming(10), 2) == 1
        errorBit = errorBit + 2;
    end
    
    
    if rem(Hamming(5) + Hamming(6) + Hamming(7) + Hamming(8), 2) == 1
        errorBit = errorBit + 4;
    end
    
    if rem(Hamming(1) + Hamming(2) + Hamming(3) + Hamming(4), 2) == 1
        errorBit = errorBit + 8;
    end
    
    if errorBit > 0
        disp(['In the letter number ', num2str(i), ' there is an error in bit ', num2str(errorBit), ' of the Hamming code']);
        Hamming(errorBit) = rem(Hamming(errorBit) + 1, 2);
    end
    
    % error corrected.
    binaryStr = uint32(zeros(8));
    
    binary(1) = 0;
    binary(2) = Hamming(1);
    binary(3) = Hamming(2);
    binary(4) = Hamming(3);
    binary(5) = Hamming(5);
    binary(6) = Hamming(6);
    binary(7) = Hamming(7);
    binary(8) = Hamming(9);
    
    str_x = num2str(binary);
    y = bin2dec(str_x);
    %disp(y);
    final_str = append(final_str, char(y));
end

disp(final_str);