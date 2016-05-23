'use strict';

import ReactNative, { NativeModules } from 'react-native';

const MaxLeapPay = NativeModules.MaxLeapPay;

async function startPayment(payment) {
  return await MaxLeapPay.startPayment(payment);
}

async function findOrder(billNo, channel) {
  let params = {billNo};
  if (typeof channel != 'undefined') {
    params.channel = channel;
  }
  return await MaxLeapPay.findOrder(params);
}

export default {
  startPayment,
  findOrder
};
