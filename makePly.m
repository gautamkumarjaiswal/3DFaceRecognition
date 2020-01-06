function makePly(mesh, fileName)

% makePly(mesh, fileName)
%
% this function converts a mesh to a *.ply file which can be rendered by 
% plyview from CyberWare and and Scanalyze from Stanford University
%
% mesh is a structure with the atleast the following two fields
% mesh.vertices and mesh.triangles
%
% Copyright : This code is written by Ajmal Saeed Mian {ajmal.mian@uwa.edu.au}
%              Computer Science, The University of Western Australia. The code
%              may be used, modified and distributed for research purposes with
%              acknowledgement of the author and inclusion this copyright information.
%
% Disclaimer : This code is provided as is without any warrantly.

noOfpoints = length(mesh.vertices);
noOfpolygons = length(mesh.triangles);

fid = fopen(fileName, 'wt');
fprintf(fid,'ply\nformat ascii 1.0\ncomment zipper output\nelement vertex %d\n', noOfpoints);
fprintf(fid,'property float x\nproperty float y\nproperty float z\nelement face %d\n', noOfpolygons);
fprintf(fid,'property list uchar int vertex_indices\nend_header\n');

for ii = 1 : noOfpoints
    fprintf(fid,'%f %f %f\n', mesh.vertices(ii,1), mesh.vertices(ii,2), mesh.vertices(ii,3));
end

polys = mesh.triangles;
polys = polys - 1;

for ii = 1 : noOfpolygons 
    fprintf(fid,'3 %d %d %d\n', polys(ii,1), polys(ii,2), polys(ii,3));
end
fclose(fid);