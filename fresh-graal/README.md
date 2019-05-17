# Native Image instructions:

0. You need to have `native-image` on the PATH.

1. Run `setup-native-image.sh` to build the project

2. Run `build-native-image.sh` to build the native image.

3. Run `run-native-image.sh` to run the native image created in the previous step.

4. Run `curl http://localhost:8080/hello/test`. It should return `Hello test!`. 
