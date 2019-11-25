str = 'Hello World';

str = uint8(str);
% disp(str);
binaryStr = dec2bin(str, 8);
% disp(binaryStr);

image = zeros(64,256);

binaryStrRow = 1;
binaryStrCol = 1;

for image_col = 31 : 30 + (11 * 8) 
    
    if(binaryStrCol > 8)
        binaryStrRow = binaryStrRow + 1;
        binaryStrCol = 1;
    end
    
    if(binaryStrRow > 11)
        break
    end
    
    if binaryStr(binaryStrRow, binaryStrCol) == '1'
        for image_row = 1 : 64
            image(image_row, image_col) = 255;
        end
    end
    
    binaryStrCol = binaryStrCol + 1;
    
end

img = mat2gray(image);
imshow(img);
imwrite(img, 'lines.jpg');