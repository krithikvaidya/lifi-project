a = VideoReader("video.mp4");
for k = 5 : 10
    I = read(a,k);
    I=imrotate(I,90);
    I1 = rgb2gray(I);
    binaryImage=imbinarize(I1);
    binaryImage=bwareafilt(binaryImage,1);
    props = regionprops(binaryImage, 'Centroid');
    xCentroid = props.Centroid(1);
    yCentroid = props.Centroid(2) - 50;
    [r c] = size(binaryImage);
    if xCentroid > c-400
        xCentroid = xCentroid - 200;
    end
    croppedImage = imcrop(I1, [xCentroid yCentroid,400,100]);
    binImg = imbinarize(croppedImage);
    se = strel('line',50,90);
    BW2 = imdilate(binImg,se);
    [labeledImage, numberOfEdges] = bwlabel(BW2);
    totEdges(k) = numberOfEdges;
    binImg = imrotate(binImg, 270);
    imshow(binImg);
end


disp(totEdges);