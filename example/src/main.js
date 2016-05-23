import React, { Component } from 'react';
import ReactNative, { View, Text, TouchableHighlight } from 'react-native';
import HelpCenter from 'maxleap-helpcenter-react-native';

const styles = {
  container: {
    justifyContent: 'center',
    flex: 1
  },
  btnText: {
    textAlign: 'center',
    fontSize: 18
  },
  btn: {
    height: 50,
    justifyContent: 'center'
  }
};

export default class Main extends Component {
  render() {
    return (
      <View style={styles.container}>
        <TouchableHighlight onPress={()=>HelpCenter.showFAQs()}
                            underlayColor={'#32BE78'}
                            style={styles.btn}>
          <Text style={styles.btnText}>
            Help
          </Text>
        </TouchableHighlight>
        <TouchableHighlight onPress={()=>HelpCenter.showConversation()}
                            underlayColor={'#F2BE78'}
                            style={styles.btn}>
          <Text style={styles.btnText}>
            Contact Us
          </Text>
        </TouchableHighlight>
      </View>
    );
  }
}
