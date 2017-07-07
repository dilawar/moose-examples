echo "Usage:"
echo "Manually set variables GPU_BUILD_DIR and CPU_BUILD_DIR in the script"
echo "sh check_script.sh <PATH TO MOOSE-SCRIPT>"
echo "Note: MOOSE-SCRIPT should take atleast one argument"
echo "First argumnet is the folder path to dump files"


GPU_BUILD_DIR="/home/teja/Work/ncbs/moose-core/build"
CPU_BUILD_DIR="/home/teja/Work/ncbs/moose-core/cpu_build"

SCRIPT_PATH=$1

CPU_DUMP="./cpu/"
GPU_DUMP="./gpu/"

# Removing data of previous runs and making directory
if [ -d "$CPU_DUMP" ]; then
	rm -rf "$CPU_DUMP"
fi
mkdir $CPU_DUMP

if [ -d "$GPU_DUMP" ]; then	
	rm -rf "$GPU_DUMP"
fi
mkdir $GPU_DUMP


# Run the experiment with CPU build
export PYTHONPATH="$CPU_BUILD_DIR/python"
python $SCRIPT_PATH $CPU_DUMP

# Run the experiment with GPU build
export PYTHONPATH="$GPU_BUILD_DIR/python"
python $SCRIPT_PATH $GPU_DUMP


# Check error between cpu and gpu
echo "################### COMPARISION BEGINS GPU/CPU ##############"
echo "Filename, TotalError, AvgError"
for filename in $(ls $CPU_DUMP); do
	python check_error.py "$CPU_DUMP$filename" "$GPU_DUMP$filename"
done
echo "################### COMPARISION ENDS GPU/CPU ##############"

echo "If you see very large non-zero values, then GPU is giving erronous results"
