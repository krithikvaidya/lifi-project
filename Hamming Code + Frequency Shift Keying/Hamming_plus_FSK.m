str = 'Hello World';

str = uint8(str);
binaryStr = dec2bin(str, 8);
 
Hamming = uint32(zeros(11, 11));
for i = 1 : 11
    step_size = uint32(2);
    Hamming(i,1) = uint32(binaryStr(i, 2) - 48);
    Hamming(i,2) = uint32(binaryStr(i, 3) - 48);
    Hamming(i,3) = uint32(binaryStr(i, 4) - 48);
    Hamming(i,4) = uint32(0);
    Hamming(i,5) = uint32(binaryStr(i, 5)- 48);
    Hamming(i,6) = uint32(binaryStr(i, 6)- 48);
    Hamming(i,7) = uint32(binaryStr(i, 7)- 48);
    Hamming(i,8) = uint32(0);
    Hamming(i,9) = uint32(binaryStr(i, 8)- 48);
    Hamming(i,10) = uint32(0);
    Hamming(i,11) = uint32(0);
    
    sum = uint32(0);
    ctr = 0;
    
    for  j = 11 : -1 : 1
        if rem(ctr, 2) == 0
            sum = sum + Hamming(i,j);
        end
        ctr = ctr + 1;
    end
    
    if rem(sum, uint32(2)) == uint32(1)
        Hamming(i, 11) = 1;
    end
    
    sum = 0;
    ctr = 0;
    
    for  j = 11 : -1 : 1
        if rem(ctr, 4) <= 1
            sum = sum + Hamming(i,j);
        end
        ctr = ctr + 1;
    end
    
    if rem(sum, 2) == 1
        Hamming(i, 10) = 1;
    end
    
    if rem(Hamming(i, 5) + Hamming(i, 6) + Hamming(i, 7) + Hamming(i, 8), 2) == 1
        Hamming(i, 8) = 1; 
    end
    
    if rem(Hamming(i, 1) + Hamming(i, 2) + Hamming(i, 3) + Hamming(i, 4), 2) == 1
        Hamming(i, 4) = 1;
  
    end
end

disp(Hamming);
image = uint32(255)*uint32(ones(64,1024));
ham_col = 1;
ham_row = 1;
    
for image_col = 31 : 5 : 30 + (11*11*5)
    
    temp = image_col;
    if(ham_col > 11)
        ham_row = ham_row + 1;
        ham_col = 1;
    end
    
    if(ham_row > 11)
        break;
    end
    
    if(Hamming(ham_row,ham_col) == 1)

        temp = temp + 1;
        for image_row = 1:64
            image(image_row, temp) = 0;
        end

        temp = temp + 2;
        for image_row = 1:64
            image(image_row, temp) = 0;
        end
    end
    
    if(Hamming(ham_row,ham_col) == 0)
        temp = temp + 2;
        for image_row = 1:64
            image(image_row, temp) = 0;
        end
    end
   
    ham_col = ham_col + 1;
    
end

img = mat2gray(image);
imshow(img);
imwrite(img, 'lines.jpg');