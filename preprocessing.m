    %Modify workspace_add and imgFolder path
    workspace_add = '\your\workspace\folder'; 
    %For example 'F:\3d_images\project_3d_feature\'
    imgFolder = strcat(workspace_add,'data\folder');
    %For example mat3_face\data_selected

    %gunzip image data using matlab inbuilt function if you don't have data in
    %.abs format
    filePattern = fullfile(imgFolder, '*.abs');
    jpegFiles = dir(filePattern);
    a=dir([imgFolder, '/*.abs']);
    numberofFiles = size(a,1);

    for k = 1:length(jpegFiles)
        baseFileName = jpegFiles(k).name;
        fullFileName = fullfile(imgFolder, baseFileName);
        [X,Y,Z,FL] = absload(fullFileName);

        Z= abs(Z);

        X= X(:);
        Y = Y(:);
        Z = Z(:);

        X1 = X(X~=-999999);
        Y1 = Y(Y~=-999999);
        Z1 = Z(Z~=999999);

        ptCloud = pointCloud2rawMesh([X1 Y1 Z1],0.6,1);

        [nose_z, nose_ind] = min(ptCloud.vertices(:,3));
        nose_pt = ptCloud.vertices(nose_ind,:);

        cropped_points = zeros(1,3);
        for ind = 1:length(ptCloud.vertices)
            if inxrange(ptCloud.vertices(ind,1),nose_pt) && inyrange(ptCloud.vertices(ind,2), nose_pt)
                cropped_points = [cropped_points; ptCloud.vertices(ind,:)];
            end
        end
        cropped_points = cropped_points((2:end),:);

        xx = double(cropped_points(:,1));
        yy = double(cropped_points(:,2));
        zz = double(cropped_points(:,3));
        zz = -zz;

        %uncomment if you want to see cropped image
        %mm = pointCloud2rawMesh([xx yy zz],0.6,1);
        %makePly(mm, 'my_cropped.ply');
        %ptCloud_cropped = pcread('my_cropped.ply');
        %pcshow(ptCloud_cropped);

        %remove spike and save despiked image following removing noise 
        %m_test = pointCloud2mesh([xx,yy,zz]);
        %zz_despiked_test = medfilt3(m_test);
        %ZI_test = interpn(zz_despiked_test,.9,'cubic');
        %zz_denoised_test = imgaussfilt3(ZI_test);
        %makePly(zz_denoised_test, 'zz_denoised_test.ply');
        %zz_denoised_test = pcread('zz_denoised_test.ply');
        %pcshow(zz_denoised_test);
        try
        %Despiking process    
        zz_despiked = medfilt3(zz);

        %Multidimensional data interpolation for filling holes
        ZI = interpn([xx,yy,zz_despiked],.9,'cubic');
        
        %denoising process
        zz_denoised = imgaussfilt3(ZI(:,3));
        mesh = pointCloud2mesh([xx,yy,zz_denoised]);
        catch MExc
        end
    end
    fclose(fid);
% end
function inRng = inxrange(val, nose_pt)
        x_llmt = -70 + nose_pt(:,1);
        x_ulmt = 70 - nose_pt(:,1);
        if val >= x_llmt && val <= x_ulmt
            inRng = 1;
        else
            inRng = 0;
        end
end

function inRng = inyrange(val, nose_pt)
    y_llmt = -70 + nose_pt(:,2);
    y_ulmt = 70 - nose_pt(:,2);
    if val >= y_llmt && val <= y_ulmt
        inRng = 1;
    else
        inRng = 0;
    end
end

