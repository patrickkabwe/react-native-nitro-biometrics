import { type HybridObject } from 'react-native-nitro-modules'
import { NitroBiometryType, type NitroBiometricsOptions } from './type'

export interface NitroBiometrics extends HybridObject<{ ios: 'swift', android: 'kotlin' }> {
    authenticate(options: NitroBiometricsOptions): Promise<boolean>
    isAvailable(): Promise<boolean>
    getAvailableBiometryType(): Promise<NitroBiometryType>
}