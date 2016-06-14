'use strict';

import ReactNative, { NativeModules } from 'react-native';
const MaxLeapPay = NativeModules.MaxLeapPay;

const MAXPAY_CHANNEL_ALI_APP    = 'ali_app'
const MAXPAY_CHANNEL_WX_APP     = 'wx_app'
const MAXPAY_CHANNEL_UNIPAY_APP = 'unipay_app'

/**
 * 发起支付请求
 *
 * @param  {[object]} payment The payment configuration.
 * @return {[promise]}        A promise that resolves with an object.
 */
async function startPayment(payment) {
  return await MaxLeapPay.startPayment(payment);
}

/**
 * Query the payemnt records.
 *
 * @param  {[string]} billNo  发起支付时生成的交易流水号
 * @param  {[string]} channel 支付渠道
 * @return {[promise]}        一个 promise 对象，成功时返回一个数组
 */
async function findRecords(billNo, channel) {
  let params = {billNo};
  if (typeof channel != 'undefined') {
    params.channel = channel;
  }
  return await MaxLeapPay.findRecords(params);
}

export default {
  startPayment,
  findRecords
};
