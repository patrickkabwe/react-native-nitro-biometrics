#include <jni.h>
#include "NitroBiometricsOnLoad.hpp"

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void*) {
  return margelo::nitro::nitrobiometrics::initialize(vm);
}
