#!/usr/bin/env bash

PYC=/opt/pyenv/shims/python
SUCCEEDED=/home/travis/build/BhallaLab/moose-examples/_travis/SUCCEEDED
FAILED=/home/travis/build/BhallaLab/moose-examples/_travis/FAILED
BLACKLISTED=/home/travis/build/BhallaLab/moose-examples/_travis/BLACKLISTED
TEMP=/home/travis/build/BhallaLab/moose-examples/_travis/TEMP
TIMEOUT=30s

FILE="$1"
echo "++ Executing script $FILE"

_DIR=$(dirname $FILE)
_FS=$(basename $FILE)

cp ./matplotlibrc $_DIR/
(
cd $_DIR
timeout $TIMEOUT $PYC $_FS &> $TEMP
status=$?
if [ "$status" -eq "0" ]; then                   # success
    echo "|| Success. Written to $SUCCEEDED"
    echo "- [x] $FILE" >> $SUCCEEDED
    # If there is timeout then add to BLACKLISTED
    # For return status See 
    # http://git.savannah.gnu.org/cgit/coreutils.git/tree/src/timeout.c
elif [ "$status" -eq "124" ]; then               # timeout. 
    echo "|| Timed-out status: $status" 
    echo "- [ ] $FILE" >> $BLACKLISTED
    sed -i 's/^/\ \ /' $TEMP
    printf "\n\`\`\`\n" >> $BLACKLISTED 
    cat $TEMP >> $BLACKLISTED 
    printf "\`\`\`\n" >> $BLACKLISTED 
else                                    # Failed
    echo "|| Failed with status "$status" "
    echo "- [ ] $FILE" >> $FAILED
    sed -i 's/^/\ \ /' $TEMP
    printf "\n\`\`\`\n" >> $FAILED 
    cat $TEMP >> $FAILED 
    printf "\`\`\`\n" >> $FAILED 
    cat $TEMP
    echo "|| Failed. Error written to $FAILED"
fi
)
