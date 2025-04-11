import { NitroModules } from 'react-native-nitro-modules'
import type { NitroBiometrics as NitroBiometricsSpec } from './specs/biometric-auth.nitro'

export const NitroBiometrics =
  NitroModules.createHybridObject<NitroBiometricsSpec>('NitroBiometrics')