imf_bmp = 'img/lena512.bmp';
imf_jpg = 'img/lena512.jpg';
imf_jp2 = 'img/lena512.jp2';

I = imread(imf_bmp);
bits_origin   = imfbits(imf_bmp);

bits_goal_jpg = 0.3 * (512*512); %#ok<NASGU>
imwrite(I, imf_jpg, 'Quality', 15);

bits_goal_jp2  = imfbits(imf_jpg);
ratio_goal_jp2 = bits_origin / bits_goal_jp2;
imwrite(I, imf_jp2, 'CompressionRatio', ratio_goal_jp2);

bpp_jpg_str = num2str(imfbits(imf_jpg) / 512^2);
bpp_jp2_str = num2str(imfbits(imf_jp2) / 512^2);
snr_jpg_str = num2str(imfsnr(imf_jpg, imf_bmp));
snr_jp2_str = num2str(imfsnr(imf_jp2, imf_bmp));

disp(  '-----------------------'        )
disp([ 'JPG file -> ' imf_jpg          ])
disp([ 'Final bpp: ' bpp_jpg_str       ])
disp([ 'SNR: ' snr_jpg_str             ])
disp(  '-----------------------'        )
disp([ 'JP2 file -> ' imf_jp2          ])
disp([ 'Final bpp: ' bpp_jp2_str       ])
disp([ 'SNR: ' snr_jp2_str             ])
disp(  '-----------------------'        )

clear imf_bmp imf_jpg imf_jp2
clear I bits_origin
clear bits_goal_jpg bits_goal_jp2 ratio_goal_jp2
clear bpp_jpg_str bpp_jp2_str snr_jpg_str snr_jp2_str

function size = imfbits(imf)
size = extractfield(imfinfo(imf), 'FileSize') * 8;
end

function snr = imfsnr(imf_target, imf_origin)
target  = imread(imf_target);
origin  = imread(imf_origin);
target2 = target.^2;
err2    = (target-origin).^2;
snr     = sum(target2(:)) / sum(err2(:));
end
