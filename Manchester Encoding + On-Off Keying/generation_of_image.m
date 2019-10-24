str = 'Hello World';

str = uint8(str);
disp(str);
binaryStr = dec2bin(str, 8);
disp(binaryStr);

manchester = zeros(11, 14);

for i = 1 : 11
    for j =  1 : 8
        k = 2 * j;
        if(binaryStr(i,j) == '0')
            manchester(i,k) = 1;
            
        else
            manchester(i,k-1) = 1;    
        end
        
    end
end

image = zeros(64,256);

man_col = 1;
man_row = 1;

for image_col = 31 : 30 + (11 * 16) 
    if(man_row > 11)
        break
    end
    
    if(man_col > 16)
        man_row = man_row + 1;
        man_col = 1;
    end
    
    if(manchester(man_row,man_col) == 1)
        for image_row = 1:64
            image(image_row, image_col) = 255;
        end
    end

    man_col = man_col + 1;
    
end

img = mat2gray(image);
imwrite(img, 'lines.jpg');
% disp(img);