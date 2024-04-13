/**
 * @return {string} 
 */
import {keyData} from '../../key/key.js' ;
import axios from '../plugins/axiosBase.js';




const getIP = async () => {
  try {
    const response = await fetch('https://api64.ipify.org?format=json');
    if (!response.ok) {
      throw new Error('无法获取IP地址');
    }
    const data = await response.json();
    const userIP = data.ip;
    return userIP;
  } catch (error) {
    console.error('获取IP地址时出现错误：', error);
    return '0.0.0.1';
  }
};
const getCity = async (IP) => {
  if (IP !== '0.0.0.1') {
      try {
          const res = await axios.get('/get_city', { params: { ip: IP } });
          // console.log(res);
          if (res.code === 200) {
              // console.log(res.city);
              return res.city!=''?res.city:"南京";
          }
      } catch (error) {
          console.error('获取城市地址时出现错误：', error);
      }
  }else{
    return '手动定位';
  }
};
// console.log(await getCity());
// //    try {
//       const response = await fetch(`https://apis.map.qq.com/ws/location/v1/ip?ip=${IP}&key=IDHBZ-7F2KM-SFY6S-6OQYE-6VWRE-WVB5N`);
//       if (!response.ok) {
//         throw new Error('无法获取城市地址');
//       }
//       const data = await response.json();
//       // console.log(data);
//       if(data.status==0){
//         const city=data.result.ad_info.city
//         // console.log(city);
//         return city;
//       }else{
//         throw new Error("解析错误")
//       }
//     } catch (error) {
//       console.error('获取城市地址时出现错误：', error);
//       return '手动定位';
//     }
export {getIP,getCity}