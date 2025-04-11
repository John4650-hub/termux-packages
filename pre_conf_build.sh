#/bin/bash
JOHN_PKG_TO_BUILD="$1"
JOHN_PKG_BUILD_SCRIPT=$(find "./packages/$JOHN_PKG_TO_BUILD" -type f -name "build.sh")
JOHN_PKG_DEPENDS=$(grep "TERMUX_PKG_DEPENDS" $JOHN_PKG_BUILD_SCRIPT | sed -n 's/.*"\([^"]*\)".*/\1/p')

IFS="," read -r -a dep_array <<< "$JOHN_PKG_DEPENDS"

build_script_paths=("$JOHN_PKG_BUILD_SCRIPT")

for dep_ in "${dep_array[@]}"; do
  dep_=$(echo "$dep_" | xargs) #remove white space from beginning
  find_exact_path=$(find "./packages/$dep_" -type f -name "build.sh")
  build_script_paths+=("$find_exact_path")
done
add_script=$(echo "
termux_step_pre_configure() {
        LDFLAGS+=\"-static-libgcc -static-libstdc++ -fopenmp -static-openmp -landroid-posix-semaphore\"
}
")
for p in "${build_script_paths[@]}";do
  echo "$add_script" >> "$p"
done

