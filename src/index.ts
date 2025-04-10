import { NitroModules } from 'react-native-nitro-modules'
import type { BiometricAuth as BiometricAuthSpec } from './specs/biometric-auth.nitro'

export const BiometricAuth =
  NitroModules.createHybridObject<BiometricAuthSpec>('BiometricAuth')