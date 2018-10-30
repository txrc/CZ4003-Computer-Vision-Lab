% 2.1 Contrast Stretching

% Part A
	Pc = imread('./images/mrttrainbland.jpg');
	whos Pc
	P = rgb2gray(Pc);

% Part B
	imshow(P);

% Part C
	a = min(P(:))
	b = max(P(:))

% Part D
	norm = imsubtract(double(P), double(a)) / imsubtract(double(b), double(a));
	output_s = uint8(255.0*norm);
	figure, imshow(output_s)
	figure, imshow(P)
	P2 = output_s; 
	min(P2(:))
	max(P2(:))

% Part E
	imshow(P2);
	imshow(P2, []);
	
% 2.2 Histogram Equalization

% Part A
	imhist(P,10)
	imhist(P, 256)

% Part B
	P3 = histeq(P,255);
	figure, imhist(P3, 10)
	figure, imhist(P3,256)
% Part C
	P3 = histeq(P,255);
	figure, imhist(P3, 10)
	figure, imhist(P3,256)


% 2.3 Linear Spatial Filtering

% Part A
	PSF = fspecial('gaussian', 5, 1);
	PSF2 = fspecial('gaussian', 5, 2);
	figure, mesh(PSF)
	figure, mesh(PSF2)

% Part B
	PIC = imread('./images/ntugn.jpg');
	imshow(PIC);
	
% Part C
	% Wrong Code
	Output = conv2(PIC,PSF);
	Output2 = conv2(PIC,PSF2);
	figure, imshow(uint8(Output))
	figure, imshow(uint8(Output2))

	% Correct Code
	Output = conv2(PIC,PSF, 'same');
	Output2 = conv2(PIC,PSF2, 'same');
	figure, imshow(uint8(Output))
	figure, imshow(uint8(Output2))

% Part D
	specPIC = imread('./images/ntusp.jpg');
	imshow(specPIC);

% Part E
	specOutput1 = conv2(specPIC, PSF, 'same');
	specOutput2 = conv2(specPIC, PSF2, 'same');
	figure, imshow(uint8(specOutput1))
	figure, imshow(uint8(specOutput2))
	

% 2.4 Median Filtering
	medF = medfilt2(PIC, [3 3]);
	medF2 = medfilt2(PIC, [5 5]);
	figure, imshow(medF)
	figure, imshow(medF2)


% 2.5 Suppressing Noise Interference Patterns

% Part A
	picInt = imread('./images/pckint.jpg');
	imshow(picint)

% Part B
	F = fft2(picInt);
	S = abs(F);
	imagesc(fftshift(S.^0.1));
	colormap('default')
	figure, imagesc(fftshift(S.^0.1));
	figure, imshow(picInt);
	colormap(gray)

% Part C
	[x,y] = ginput(2)


% Part D

	% Wrong axis
	F = fft2(picInt);
	F(16:20, 247:251) = 0;
	F(239:243, 8:12) = 0;
	newS = abs(F);
	imagesc(fftshift(newS.^0.1))
	colormap('default')
	colormap(gray)

	% Correct axis
	F = fft2(picInt);
	F(16:20, 247:251) = 0;
	F(239:243, 8:12) = 0;
	newS = abs(F);
	imagesc(fftshift(newS.^0.1))
	colormap('default')
	colormap(gray)

% Part E
	transformedImage = uint8(ifft2(F));
	imshow(transformedImage);
	

% Part F

	% Read in Image
	primateIMG = imread('./images/primatecaged.jpg');
	primateIMG = rgb2gray(primateIMG);
	imshow(primateIMG)
	
	% View image before setting peaks to zero
	F = fft2(primateIMG);
	S = abs(F);
	imagesc(S.^0.1)

	% Get peaks, select parts that are bright dots 
	[y,x] = ginput

	y = round(y) % round Y values 
	x = round(x) % round X values

	% All 8 Spotted Peaks
	F(x(1)-2:x(1)+2, y(1)-2:y(1)+2) = 0;
	F(x(2)-2:x(2)+2, y(2)-2:y(2)+2) = 0;
	F(x(3)-2:x(3)+2, y(3)-2:y(3)+2) = 0;
	F(x(4)-2:x(4)+2, y(4)-2:y(4)+2) = 0;
	F(x(5)-2:x(5)+2, y(5)-2:y(5)+2) = 0;
	F(x(6)-2:x(6)+2, y(6)-2:y(6)+2) = 0;
	F(x(7)-2:x(7)+2, y(7)-2:y(7)+2) = 0;
	F(x(8)-2:x(8)+2, y(8)-2:y(8)+2) = 0;

	% View the Image in the Power Spectrum
	S = abs(F);
	imagesc(S.^0.1)

	% Invert the Fourier Transform Operation and display image
	primateNew = ifft2(F);
	primateNew = uint8(ifft2(F));
	imshow(primateNew)


% 2.6 Undoing Perspective Distortion of Planar Surface

% Part A
	P = imread('./images/book.jpg');
	imshow(P);

% Part B
	[X Y] = ginput(4);
	% For replicating experiment
	% X = [143.0000 309.0000 7.0000 255.0000]
	% Y = [28.0000 48.0000 160.0000 213.0000]
	[X Y]
	imageX = [0 210 0 210];
	imageY = [0 0 297 297];

% Part C
	A = [
    		[X(1), Y(1), 1, 0, 0, 0, -imageX(1)*X(1), -imageX(1)*Y(1)];
    		[0, 0, 0, X(1), Y(1), 1, -imageY(1)*X(1), -imageY(1)*Y(1)];
    		[X(2), Y(2), 1, 0, 0, 0, -imageX(2)*X(2), -imageX(2)*Y(2)];
    		[0, 0, 0, X(2), Y(2), 1, -imageY(2)*X(2), -imageY(2)*Y(2)];
    		[X(3), Y(3), 1, 0, 0, 0, -imageX(3)*X(3), -imageX(3)*Y(3)];
    		[0, 0, 0, X(3), Y(3), 1, -imageY(3)*X(3), -imageY(3)*Y(3)];
    		[X(4), Y(4), 1, 0, 0, 0, -imageX(4)*X(4), -imageX(4)*Y(4)];
    		[0, 0, 0, X(4), Y(4), 1, -imageY(4)*X(4), -imageY(4)*Y(4)];
	];
	v = [imageX(1); imageY(1); imageX(2); imageY(2); imageX(3); imageY(3); imageX(4); imageY(4)];
	
	u = A \ v;
	U = reshape([u;1], 3, 3)'; 
	w = U*[X'; Y'; ones(1,4)];
	w = w ./ (ones(3,1) * w(3,:));

% Part D
	T = maketform('projective', U');
	P2 = imtransform(P, T, 'XData', [0 210], 'YData', [0 297]);

% Part E
	imshow(P2);