Build static libraries on windows
=================================

Tool set
--------
* CMake
* git
* SWIG
* Visual Studio 2015 with C++ tools
* Python 3.5.4 (need DEBUG symbols and binaries if you want to build the debug version of the lib)
* linux shell on windows (e.g. ubuntu on windows)

Prepare the source code
-----------------------
* start "VS2015 x64 Native Tools Command Prompt" (Make sure we are using the x64 tools)
* Clone the repo
  ```text
  git clone https://github.com/leohoo/tensorflow.git
  git checkout mybuild
  ```
* Edit cmake-release.bat / cmake-debug.bat
  ```text
  cd tensorflow¥tensorflow¥contrib¥cmake
  notepad urobot¥cmake-release.bat
  ```
  Change swig and python paths to match your environment
  ```text
  cmake .. -A x64 -DCMAKE_BUILD_TYPE=Release ^
  -Dtensorflow_BUILD_ALL_KERNELS=OFF ^
  -Dtensorflow_BUILD_PYTHON_BINDINGS=OFF ^
  -Dtensorflow_BUILD_CC_EXAMPLE=OFF ^
  -Dtensorflow_BUILD_CONTRIB_KERNELS=OFF ^
  -DSWIG_EXECUTABLE=<PATH TO YOUR SWIG.EXE> ^
  -DPYTHON_EXECUTABLE=<PATH TO YOUR PYTHON.EXE> ^
  -DPYTHON_LIBRARIES=<PATH TO YOUR python35.lib>
  ```
* CMake
  ```text
  mkdir build
  cd build
  ..¥urobot¥cmake-release.bat
  ```
* MSBuild
  ```text
  msbuild /p:Configuration=Release ALL_BUILD.vcxproj /fl
  ```
  `/fl` will create a build log (msbuild.log)
  
* Copy the target libs into a single folder
  You need a bash shell (e.g. ubuntu on windows) to run the script
  
  ```text
  <cd to your build directory>
  ../urobot/copylibs.sh Release <PATH TO THE RELEASE LIB FOLDER>
  ```
* copy all the header files into one folder
  ```text
  export INC=<PATH TO YOUR INCLUDE FOLDER>
  
  # in tensorflow repo root
  find tensorflow/core -name "*.h" -exec rsync -R {} $INC \;
  rsync -R tensorflow/cc/framework/*.h $INC
  rsync -R tensorflow/cc/ops/*.h $INC
  rsync -R -a third_party/eigen3 $INC

  cd tensorflow/contrib/cmake/build
  rsync -R tensorflow/cc/ops/*.h $INC
  find tensorflow/core -name "*.h"  -exec rsync -R {} $INC \;
  rsync -avhP --exclude signature_of_eigen3_matrix_library external/eigen_archive/ $INC
  cp external/nsync/public/*.h  $INC

  cd protobuf/src/protobuf/src
  find google -name "*.h" -exec rsync -R {} $INC \;
  ```
