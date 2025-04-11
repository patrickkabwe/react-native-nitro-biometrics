package com.nitrobiometrics

import androidx.biometric.BiometricPrompt
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import com.margelo.nitro.NitroModules
import com.margelo.nitro.core.Promise
import com.margelo.nitro.nitrobiometrics.HybridNitroBiometricsSpec
import com.margelo.nitro.nitrobiometrics.NitroBiometricsOptions
import com.margelo.nitro.nitrobiometrics.NitroBiometryType
import java.util.concurrent.Executor

class HybridNitroBiometrics: HybridNitroBiometricsSpec() {
    private val reactContext = NitroModules.applicationContext ?: run {
        throw Error("Context is null")
    }
    private val executor: Executor = ContextCompat.getMainExecutor(reactContext)

    @RequiresApi(Build.VERSION_CODES.P)
    override fun authenticate(options: NitroBiometricsOptions): Promise<Boolean> {
        return Promise.async {
            val authActivity = reactContext.currentActivity as? FragmentActivity
                ?: throw Error("Activity is not a FragmentActivity")

            val authPrompt = BiometricPrompt.PromptInfo.Builder().apply {
                setTitle("Test")
                setSubtitle("Test Sub")
                setDescription("Test Desc")
            }.build()

            val biometricPrompt = BiometricPrompt(authActivity, executor,
                object : BiometricPrompt.AuthenticationCallback() {
                    override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                        print("onAuthenticationSucceeded")
                    }

                    override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                        print("onAuthenticationError")
                    }

                    override fun onAuthenticationFailed() {
                        print("onAuthenticationFailed")
                    }
                })
            biometricPrompt.authenticate(authPrompt)

            false
        }

    }

    override fun isAvailable(): Promise<Boolean> {
        return Promise.async {
            true
        }
    }

    override fun getAvailableBiometryType(): Promise<NitroBiometryType> {
        return Promise.async {
            NitroBiometryType.FACEID
        }
    }
}
