const useGetCity=async(ip)=>{
    try {
        const response = await fetch(`https://apis.map.qq.com/ws/location/v1/ip?${ip}=$%7BIP%7D&key=IDHBZ-7F2KM-SFY6S-6OQYE-6VWRE-WVB5N`);
        // console.log(response);
        if (!response.ok) {
          throw new Error('无法获取城市地址');
        }
        const data = await response.json();
        // console.log(data);
        if(data.status==0){
          const city=data.result.ad_info.city
          // console.log(city);
          return city;
        }else{
          throw new Error("解析错误")
        }
      } catch (error) {
        console.error('获取城市地址时出现错误：', error);
        return '南京';
      }
}
// const ip="120.243.227.17"
module.exports = useGetCity
// getCity(ip).then(city => {
//         console.log(city);
//     }).catch(error => {
//         console.error(error);
//     });


