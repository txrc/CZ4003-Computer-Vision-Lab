% 2.1 Edge Detection 

% Part A 
    pic = imread('./images/macritchie.jpg');
    pic_gray = rgb2gray(pic);
    imshow(pic_gray)
    
% Part B
    sobel_vertical = [-1 -2 -1; 0 0 0; 1 2 1];
    sobel_vertical
    sobel_horizontal = [-1 0 1; -2 0 2; -1 0 1];
    sobel_horizontal
    
    % Convert to uint8 
    conv_image_vertical = conv2(pic_gray, sobel_vertical);
    conv_image_horizontal = conv2(pic_gray, sobel_horizontal);
    figure, imshow(uint8(conv_image_vertical)) 
    figure, imshow(uint8(conv_image_horizontal))

% Part C
    
    conv_image_vertical = conv2(pic_gray, sobel_vertical);
    conv_image_horizontal = conv2(pic_gray, sobel_horizontal);  
    combined_edge_image = conv_image_vertical.^2 + conv_image_horizontal.^2;
    
    imshow(uint8(sqrt(combined_edge_image))) % Following Lecture Notes Squareroot(Horizontal^2 + Vertical^2)
    imshow(uint8(combined_edge_image)) % The image is so bright. Cannot view anything
    imshow((combined_edge_image),[]) % This function normalizes the image.
    
% Part D
    % Normalization of the combined_edge_image
    conv_image_vertical = conv2(pic_gray, sobel_vertical);
    conv_image_horizontal = conv2(pic_gray, sobel_horizontal);  
    combined_edge_image = conv_image_vertical.^2 + conv_image_horizontal.^2;
    
    min_image = min(combined_edge_image(:));
    max_image = max(combined_edge_image(:));
    E = 255*(combined_edge_image - min_image)/(max_image-min_image);
    
    Et = E > 5;
    imshow(Et)
    Et = E > 20; 
    imshow(Et)
    Et = E > 50;
    imshow(Et)
    Et = E > 100;
    imshow(Et)
 
% Part E
    tl = 0.04;
    th = 0.1;
    sigma = 1.0;
    sigma_list = [1.0 2.0 3.0 4.0 5.0];
    tl_list = [0.01 ,0.04, 0.09];

    CannyEdge1 = edge(pic_gray, 'canny', [tl th], sigma_list(1));
    CannyEdge2 = edge(pic_gray, 'canny', [tl th], sigma_list(2));
    CannyEdge3 = edge(pic_gray, 'canny', [tl th], sigma_list(3));
    CannyEdge4 = edge(pic_gray, 'canny', [tl th], sigma_list(4));
    CannyEdge5 = edge(pic_gray, 'canny', [tl th], sigma_list(5));

    figure, imshow(CannyEdge1);
    figure, imshow(CannyEdge2);
    figure, imshow(CannyEdge3);
    figure, imshow(CannyEdge4);
    figure, imshow(CannyEdge5);


    CannyEdge6 = edge(pic_gray, 'canny', [(tl_list(1)) th], sigma(1));
    CannyEdge7 = edge(pic_gray, 'canny', [(tl_list(2)) th], sigma(1));
    CannyEdge8 = edge(pic_gray, 'canny', [(tl_list(3)) th], sigma(1));

    figure, imshow(CannyEdge6);
    figure, imshow(CannyEdge7);
    figure, imshow(CannyEdge8);

% 2.2 Hough Transform

% Part A
    pic = imread('macritchie.jpg');
    pic_gray = rgb2gray(pic);
    tl = 0.04;
    th = 0.1;
    sigma = 1.0;
    E = edge(pic_gray, 'canny', [tl, th], sigma);
    
% Part B
    theta = 0:179;
    [H, xp] = radon(E);
    imshow(uint8(H));

% Part C
    [H, xp] = radon(E);
    imagesc(uint8(H)); % Use Data Cursor Icon in the Figures toolbar and choose the different peaks and see which has the highest RGB.
    
% Part D
    % Center of the pic is (290 / 2) = 145 by (358 / 2) = 179 - Y by X
    theta = 104;
    radius = xp(157);
    [A, B] = pol2cart(theta*pi/180, radius);
    B = -B;
    C = A*(A+179) + B*(B+145);
    
% Part E
    xl = 0;
    yl = (C - A * xl) / B;
    xr = 357;
    yr = (C - A * xr) / B;

% Part F
    imshow(pic_gray)
    line([xl xr], [yl yr])
    
    % Correction for part D to F.
    theta = 103;
    radius = xp(157);
    [A, B] = pol2cart(theta*pi/180, radius);
    B = -B;
    C = A*(A+179) + B*(B+145);
    
    xl = 0;
    yl = (C - A * xl) / B;
    xr = 357;
    yr = (C - A * xr) / B;
    
    imshow(pic_gray)
    line([xl xr], [yl yr])
    
% 2.3 3D Stereo Vision
% Part A is the file map.m

% Part B
    l = imread('./images/corridorl.jpg');
    l = rgb2gray(l);
    figure, imshow(l);
    r = imread('./images/corridorr.jpg');
    r = rgb2gray(r);
    figure, imshow(r);
    
% Part C
    D = map(l, r, 11,11);
    figure, imshow(D, [-15 15]);
    check_disparity = imread('./images/corridor_disp.jpg');
    figure, imshow(check_disparity)

% Part D
    l = rgb2gray(imread('./images/triclopsi2l.jpg'));
    r = rgb2gray(imread('./images/triclopsi2r.jpg'));
    figure, imshow(l);
    figure, imshow(r);
    D = map(l, r, 11, 11);
    figure, imshow(D, [-15 15]);
    check_disparity = imread('./images/triclopsid.jpg');
    figure, imshow(check_disparity)