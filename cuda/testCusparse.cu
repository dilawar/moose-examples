#include <cusparse.h>
#include <cuda_runtime.h>
#include <iostream>
#include <cstdio>

#define CUDA_ERROR_CHECK
#define cusparseSafeCall( err ) __cusparseSafeCall( err, __FILE__, __LINE__ )

using namespace std;

inline void __cusparseSafeCall( cusparseStatus_t err, const char *file, const int line )
{
#ifdef CUDA_ERROR_CHECK
    if ( CUSPARSE_STATUS_SUCCESS != err )
    {
        std::string errMsg;
        switch(err){
            case CUSPARSE_STATUS_SUCCESS:
                errMsg =  "the operation completed successfully.";
                break;
            case CUSPARSE_STATUS_NOT_INITIALIZED:
                errMsg =  "the library was not initialized.";
                break;
            case CUSPARSE_STATUS_INVALID_VALUE:
                errMsg =  "invalid parameters were passed (mb,nnzb<=0).";
                break;
            case CUSPARSE_STATUS_ARCH_MISMATCH:
                errMsg =  "the device only supports compute capability 2.0 and above.";
                break;
            case CUSPARSE_STATUS_MAPPING_ERROR:
                errMsg =  "the texture binding failed.";
                break;
            case CUSPARSE_STATUS_EXECUTION_FAILED:
                errMsg =  "the function failed to launch on the GPU.";
                break;
            case CUSPARSE_STATUS_INTERNAL_ERROR:
                errMsg =  "an internal operation failed.";
                break;
            case CUSPARSE_STATUS_MATRIX_TYPE_NOT_SUPPORTED:
                errMsg =  "the matrix type is not supported.";
                break;
            default:
                errMsg = "Unknown cusparse error";
                break;
        }

        fprintf( stderr, "cusparseSafeCall() failed at %s:%i : %s\n",
                 file, line, errMsg.c_str() );
        exit( -1 );
    }
#endif
 
    return;
}


int main(){
cusparseHandle_t cusparse_handle=0;
cusparseMatDescr_t cusparse_descr=0;

cusparseSafeCall(cusparseCreate(&cusparse_handle));

return 0;
}

