clear
clc
display('*****************************************************');
display('             REMOVAL OF VOCAL FROM SONG              ');
display('*****************************************************');

display(' ');
display('Reading Wave File');
%Music clip that is converted from mp3 to wav
[sample_data,sampling_rate]=wavread('./sample/music.wav');
pause(5);
display('Data sampled successfully. Reading completed.');

pause(1);
display(' ');
display('Playing original wav file');
%Playing Original WAV file using in-built player
wavplay(sample_data,sampling_rate);

%Separate both channel signal from sampled data 
samples=size(sample_data);			%calculating no. of sampled data
left_channel=1:samples(1,1);		%store left channel data
right_channel=1:samples(1,1);		%store right channel data

for n = 1:samples(1,1)
	left_channel(n) = sample_data(n,1);
	right_channel(n) = sample_data(n,2);
end

%Stereo Cancellation Technique
%Get Frequency Domain using Fast Fourier Transform for both channels
left_channel_fft = fft(left_channel); 
right_channel_fft = fft(right_channel); 
%Remove center spanned vocal from music
no_voice_sample_fft = left_channel_fft - right_channel_fft;
%Apply Inverse Fast Fourier Transform to get back music
no_voice_sample = ifft(no_voice_sample_fft);

display(' ');
display('press any key to continue...');
display(' ');
pause;
display('Playing wav file without vocal');
%Playing Removed vocal WAV Instrumental audio file using in-built player
wavplay(no_voice_sample,sampling_rate);