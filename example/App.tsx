import React, {useEffect, useState} from 'react';
import {Button, StyleSheet, Text, View} from 'react-native';
import {NitroBiometrics} from 'react-native-nitro-biometrics';
import {NitroBiometryType} from '../src/specs/type';

function App(): React.JSX.Element {
  const [isAvailable, setIsAvailable] = useState(false);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [biometryType, setBiometryType] = useState<NitroBiometryType>(
    NitroBiometryType.None,
  );

  useEffect(() => {
    NitroBiometrics.isAvailable().then(setIsAvailable);
    NitroBiometrics.getAvailableBiometryType().then(setBiometryType);
  }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.text}>
        {isAvailable ? 'Available' : 'Not Available'}
      </Text>
      <Text style={styles.text}>{biometryType}</Text>
      <Text style={styles.text}>
        {isAuthenticated ? 'Authenticated' : 'Not Authenticated'}
      </Text>

      <Button
        title="Authenticate"
        onPress={() => {
          NitroBiometrics.authenticate({
            reason: 'Authenticate to access your account',
          })
            .then(setIsAuthenticated)
            .catch(console.error);
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    fontSize: 40,
    color: 'green',
  },
});

export default App;
