# 3DfaceRecognition
Development of 3D face and ear recognition system


Clone repo or download zip folder. Go to download section and unzip it. Unzipped folder will be named as "3DFaceRecognition-master". Keep the folder in the desired directory from where you want to run the code.

Modify the path of variable "workspace_add" and "imgFolder" (Line number 2 and 4)

Keep FRGC2.0 3D database images into folder "FRGC_3D_Face_Database". Initially keep only one image (or use the image i kept in the folder "FRGC_3D_Face_Database") and run the code to check wheather program can crop facial region or not, later keep all the database images in the "FRGC_3D_Face_Database" folder. Comment line 48-52 in MATLAB when you run code for whole database, as it would take long time to visualize point cloud for each image.

Run preprocess.m to perform preprecessing steps.
This main function will read image, crop facial region, despike, fill holes and denoise it. For more detail please visit article at Medium:

https://towardsdatascience.com/development-of-3d-face-recognition-using-matlab-a54ccc0b7cdd

Program is tested on MATLAB R2017a.
