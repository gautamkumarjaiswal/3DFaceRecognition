%I used the following matlab code to load these files 

%ABSLOAD Read a UND database range image from file. 
%   [X,Y,Z,FL] = ABSLOAD(FILENAME) reads the range image in FILENAME 
%   into the variables X,Y,Z,FL. 
%   FILENAME is a string that specifies the name of the file 
%            to be openned 
%   X,Y,Z are matrices representing the 3D co-ords of each point 
%   FL    is the flags vector specifying if a point is valid 
function [x, y, z, fl] = absload(fname) 

% open the file 
fid = fopen(fname); 
% read number of rows 
r = fgetl(fid); 
r = sscanf(r, '%d'); 
% read number of columns 
c = fgetl(fid); 
c = sscanf(c, '%d'); 
% read junk line 
t = fgetl(fid); clear t; 
% get flags 
fl = fscanf(fid,'%d',[c r])'; 
% get x 
x = fscanf(fid,'%f',[c r])'; 
% get y 
y = fscanf(fid,'%f',[c r])'; 
% get z 
z = fscanf(fid,'%f',[c r])';
% close the file 
fclose(fid); 