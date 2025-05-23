///
/// NitroBiometricsOnLoad.cpp
/// This file was generated by nitrogen. DO NOT MODIFY THIS FILE.
/// https://github.com/mrousavy/nitro
/// Copyright © 2025 Marc Rousavy @ Margelo
///

#ifndef BUILDING_NITROBIOMETRICS_WITH_GENERATED_CMAKE_PROJECT
#error NitroBiometricsOnLoad.cpp is not being built with the autogenerated CMakeLists.txt project. Is a different CMakeLists.txt building this?
#endif

#include "NitroBiometricsOnLoad.hpp"

#include <jni.h>
#include <fbjni/fbjni.h>
#include <NitroModules/HybridObjectRegistry.hpp>

#include "JHybridNitroBiometricsSpec.hpp"
#include <NitroModules/JNISharedPtr.hpp>
#include <NitroModules/DefaultConstructableObject.hpp>

namespace margelo::nitro::nitrobiometrics {

int initialize(JavaVM* vm) {
  using namespace margelo::nitro;
  using namespace margelo::nitro::nitrobiometrics;
  using namespace facebook;

  return facebook::jni::initialize(vm, [] {
    // Register native JNI methods
    margelo::nitro::nitrobiometrics::JHybridNitroBiometricsSpec::registerNatives();

    // Register Nitro Hybrid Objects
    HybridObjectRegistry::registerHybridObjectConstructor(
      "NitroBiometrics",
      []() -> std::shared_ptr<HybridObject> {
        static DefaultConstructableObject<JHybridNitroBiometricsSpec::javaobject> object("com/nitrobiometrics/HybridNitroBiometrics");
        auto instance = object.create();
        auto globalRef = jni::make_global(instance);
        return JNISharedPtr::make_shared_from_jni<JHybridNitroBiometricsSpec>(globalRef);
      }
    );
  });
}

} // namespace margelo::nitro::nitrobiometrics
