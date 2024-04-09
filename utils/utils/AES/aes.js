
import CryptoJS from 'crypto-js';
// 定义密钥和初始向量
const key = CryptoJS.enc.Utf8.parse('yueyv');
const iv = CryptoJS.enc.Utf8.parse('lunhui');

// 加密方法
const encryptPassword = (password) => {
    const encrypted = CryptoJS.AES.encrypt(password, key, { iv: iv, mode: CryptoJS.mode.CBC, padding: CryptoJS.pad.Pkcs7 });
    return encrypted.toString();
};

// 使用加密方法加密密码
const encryptedPassword = encryptPassword('12345678');
console.log('Encrypted password:', encryptedPassword);
