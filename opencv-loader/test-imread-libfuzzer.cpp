/**********************************************
 *   A loader program for testing imread      *
 *   function with libFuzzer.                 *     
 *   Copy this file to:                       *
 *   /OPENCV_HOME/samples/cpps/example_cmake  *
 *   rename it example.cc                     *
 *   and compile it with Makefile.afl         *
 **********************************************/

#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <iostream>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/core/utility.hpp>

#include <assert.h>

using namespace cv;
using namespace std;

#define DEST_NAME "/tmp/goodbeef"

std::string optionalFileName;
// Read and Write a PNG file specified with const name
void pngReadWrite(const std::string filename);
void write_to_testcase(const uint8_t *mem, size_t len, const std::string filename);

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) 
{
    std::string filename = optionalFileName;
    write_to_testcase(data, size, filename);
    pngReadWrite(filename);
    return 0;
}

void pngReadWrite(const std::string filename) 
{
    Mat img;
    try {
        img = imread(filename.c_str());
        if (img.empty()) {
            return;
        }
    } catch (cv::Exception) {
        return;
    }

}

void write_to_testcase(const uint8_t * mem, size_t len, const std::string filename) 
{
    unlink(filename.c_str());
    FILE* fd = fopen(filename.c_str(), "wb+");

    if (!fd) {
        cerr << "Unable to create " <<  filename << "\n";
        printf("Reason is %s\n", strerror(errno));
        exit(0);
    }

    size_t wlen = fwrite(mem, 1, len, fd);
    if (wlen != len) {
        cerr << "Cannot write to file!\n";
        fclose(fd);
        exit(0); 
    }

    fclose(fd);
}

