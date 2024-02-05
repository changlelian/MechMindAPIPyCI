@echo off


set MechEyeAPI=%MECHEYE_DLL_PATH%
for /f "tokens=1,2 delims=;" %%a in ("%MechEyeAPI%") do (
   set first_part=%%a
   set second_part=%%b
)
set API_Folder_Path=%first_part:~0,-4%
echo API folder path is: %API_Folder_Path%

rem echo Second part: %second_part%

set Sample_Path=%API_Folder_Path%\samples\cpp
echo %Sample_Path%-------------

set "arr=\area_scan_3d_camera\Advanced\CapturePeriodically \area_scan_3d_camera\Advanced\CaptureStereo2DImages \area_scan_3d_camera\Advanced\ConvertDepthMapToPointCloud \area_scan_3d_camera\Advanced\Mapping2DImageToDepthMap \area_scan_3d_camera\Advanced\MultipleCamerasCaptureSequentially \area_scan_3d_camera\Advanced\MultipleCamerasCaptureSimultaneously \area_scan_3d_camera\Advanced\RegisterCameraEvent \area_scan_3d_camera\Advanced\SetParametersOfLaserCameras \area_scan_3d_camera\Advanced\SetParametersOfUHPCameras \area_scan_3d_camera\Basic\Capture2DImage \area_scan_3d_camera\Basic\CaptureDepthMap \area_scan_3d_camera\Basic\CapturePointCloud \area_scan_3d_camera\Basic\CapturePointCloudHDR \area_scan_3d_camera\Basic\CapturePointCloudWithNormals \area_scan_3d_camera\Basic\ConnectAndCaptureImages \area_scan_3d_camera\Basic\ConnectToCamera \area_scan_3d_camera\Calibration\HandEyeCalibration \area_scan_3d_camera\Pcl\ConvertPointCloudToPcl \area_scan_3d_camera\Pcl\ConvertPointCloudWithNormalsToPcl \area_scan_3d_camera\Util\GetCameraIntrinsics \area_scan_3d_camera\Util\ManageUserSets \area_scan_3d_camera\Util\PrintCameraInfo \area_scan_3d_camera\Util\SaveAndLoadUserSet \area_scan_3d_camera\Util\SetDepthRange \area_scan_3d_camera\Util\SetPointCloudProcessingParameters \area_scan_3d_camera\Util\SetScanningParameters \profiler\AcquirePointCloud \profiler\AcquireProfileData \profiler\AcquireProfileDataUsingCallback \profiler\ManageUserSets \profiler\RegisterProfilerEvent \profiler\UseVirtualDevice"

for %%i in (%arr%) do (
   echo %%i

   if exist "%Sample_Path%%%i\build" (
      echo Deleting existing directory: %Sample_Path%%%i\build
      rd /s /q "%Sample_Path%%%i\build"
   )

   mkdir "%Sample_Path%%%i\build"
   cd /d "%Sample_Path%%%i\build"
   cmake "%Sample_Path%%%i"
   if %ERRORLEVEL% EQU 1 (
      exit /b 1
   )
   
   cmake --build .
   if %ERRORLEVEL% EQU 1 (
      exit /b 1
   )
   echo ***********************************************************
)
