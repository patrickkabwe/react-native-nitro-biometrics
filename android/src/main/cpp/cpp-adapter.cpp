#include <jni.h>
#include "BiometricAuthOnLoad.hpp"

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void*) {
  return margelo::nitro::biometricauth::initialize(vm);
}
