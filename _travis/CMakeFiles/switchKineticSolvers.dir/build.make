# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.9

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/cmake-3.9.2/bin/cmake

# The command to remove a file.
RM = /usr/local/cmake-3.9.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/travis/build/BhallaLab/moose-examples/_travis

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/travis/build/BhallaLab/moose-examples/_travis

# Utility rule file for switchKineticSolvers.

# Include the progress variables for this target.
include CMakeFiles/switchKineticSolvers.dir/progress.make

CMakeFiles/switchKineticSolvers: ./../snippets/switchKineticSolvers.py
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/travis/build/BhallaLab/moose-examples/_travis/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Executing ./../snippets/switchKineticSolvers.py ."
	/home/travis/build/BhallaLab/moose-examples/_travis/run.sh ./../snippets/switchKineticSolvers.py

switchKineticSolvers: CMakeFiles/switchKineticSolvers
switchKineticSolvers: CMakeFiles/switchKineticSolvers.dir/build.make

.PHONY : switchKineticSolvers

# Rule to build all files generated by this target.
CMakeFiles/switchKineticSolvers.dir/build: switchKineticSolvers

.PHONY : CMakeFiles/switchKineticSolvers.dir/build

CMakeFiles/switchKineticSolvers.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/switchKineticSolvers.dir/cmake_clean.cmake
.PHONY : CMakeFiles/switchKineticSolvers.dir/clean

CMakeFiles/switchKineticSolvers.dir/depend:
	cd /home/travis/build/BhallaLab/moose-examples/_travis && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/travis/build/BhallaLab/moose-examples/_travis /home/travis/build/BhallaLab/moose-examples/_travis /home/travis/build/BhallaLab/moose-examples/_travis /home/travis/build/BhallaLab/moose-examples/_travis /home/travis/build/BhallaLab/moose-examples/_travis/CMakeFiles/switchKineticSolvers.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/switchKineticSolvers.dir/depend

