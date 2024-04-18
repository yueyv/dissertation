<script setup>
import { ref, reactive } from 'vue'
const searchContent = ref("")
</script>

<template>
    <div class="container">
        <div class="home-sider">
            <div class="home-job-menu">
                <div class="job-menu-wrapper">
                    <dl class="">
                        <dd>
                            <i class="iboss-right-fill"></i>
                            <b>互联网/AI</b>
                            <a href="/searchPage?title=软件">软件</a>
                            <a href="/searchPage?title=Java">Java</a> <a href="/searchPage?title=C/C++">C/C++</a> <a
                                href="/searchPage?title=PHP">PHP</a>
                        </dd>
                        <div class="menu-sub">
                            <p class="menu-article">互联网/AI</p>
                            <ul>
                                <li>
                                    <h4>后端开发</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=软件">软件</a>
                                        <a href="/searchPage?title=Java">Java</a> <a
                                            href="/searchPage?title=C/C++">C/C++</a> <a
                                            href="/searchPage?title=PHP">PHP</a> <a
                                            href="/searchPage?title=Python">Python</a> <a
                                            href="/searchPage?title=C#">C#</a> <a href="/searchPage?title=.NET">.NET</a>
                                        <a href="/searchPage?title=Golang">Golang</a> <a
                                            href="/searchPage?title=Node.js">Node.js</a> <a
                                            href="/searchPage?title=Hadoop">Hadoop</a> <a
                                            href="/searchPage?title=语音/视频/图形开发">语音/视频/图形开发</a> <a
                                            href="/searchPage?title=GIS工程师">GIS工程师</a> <a
                                            href="/searchPage?title=区块链工程师">区块链工程师</a> <a
                                            href="/searchPage?title=全栈工程师">全栈工程师</a> <a
                                            href="/searchPage?title=其他后端开发">其他后端开发</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>前端/移动开发</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=前端开发工程师">前端开发工程师</a> <a
                                            href="/searchPage?title=Android">Android</a> <a
                                            href="/searchPage?title=iOS">iOS</a> <a href="/searchPage?title=U3D">U3D</a>
                                        <a href="/searchPage?title=UE4">UE4</a> <a
                                            href="/searchPage?title=Cocos">Cocos</a> <a
                                            href="/searchPage?title=技术美术">技术美术</a> <a
                                            href="/searchPage?title=JavaScript">JavaScript</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>测试</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=测试工程师">测试工程师</a> <a
                                            href="/searchPage?title=软件测试">软件测试</a> <a
                                            href="/searchPage?title=自动化测试">自动化测试</a> <a
                                            href="/searchPage?title=功能测试">功能测试</a> <a
                                            href="/searchPage?title=测试开发">测试开发</a> <a
                                            href="/searchPage?title=硬件测试">硬件测试</a> <a
                                            href="/searchPage?title=游戏测试">游戏测试</a> <a
                                            href="/searchPage?title=性能测试">性能测试</a> <a
                                            href="/searchPage?title=渗透测试">渗透测试</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>运维/技术支持</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=运维工程师">运维工程师</a> <a
                                            href="/searchPage?title=IT技术支持">IT技术支持</a> <a
                                            href="/searchPage?title=网络工程师">网络工程师</a> <a
                                            href="/searchPage?title=网络安全">网络安全</a> <a
                                            href="/searchPage?title=系统工程师">系统工程师</a> <a
                                            href="/searchPage?title=运维开发工程师">运维开发工程师</a> <a
                                            href="/searchPage?title=系统管理员">系统管理员</a> <a
                                            href="/searchPage?title=DBA">DBA</a> <a
                                            href="/searchPage?title=系统安全">系统安全</a> <a
                                            href="/searchPage?title=技术文档工程师">技术文档工程师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>人工智能</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=图像算法">图像算法</a> <a
                                            href="/searchPage?title=自然语言处理算法">自然语言处理算法</a> <a
                                            href="/searchPage?title=大模型算法">大模型算法</a> <a
                                            href="/searchPage?title=数据挖掘">数据挖掘</a> <a
                                            href="/searchPage?title=规控算法">规控算法</a> <a
                                            href="/searchPage?title=SLAM算法">SLAM算法</a> <a
                                            href="/searchPage?title=推荐算法">推荐算法</a> <a
                                            href="/searchPage?title=搜索算法">搜索算法</a> <a
                                            href="/searchPage?title=语音算法">语音算法</a> <a
                                            href="/searchPage?title=风控算法">风控算法</a> <a
                                            href="/searchPage?title=算法研究员">算法研究员</a> <a
                                            href="/searchPage?title=算法工程师">算法工程师</a> <a
                                            href="/searchPage?title=机器学习">机器学习</a> <a
                                            href="/searchPage?title=深度学习">深度学习</a> <a
                                            href="/searchPage?title=自动驾驶系统工程师">自动驾驶系统工程师</a> <a
                                            href="/searchPage?title=数据标注/AI训练师">数据标注/AI训练师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>销售技术支持</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=售前技术支持">售前技术支持</a> <a
                                            href="/searchPage?title=售后技术支持">售后技术支持</a> <a
                                            href="/searchPage?title=销售技术支持">销售技术支持</a> <a
                                            href="/searchPage?title=客户成功">客户成功</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>数据</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=数据分析师">数据分析师</a> <a
                                            href="/searchPage?title=数据开发">数据开发</a> <a
                                            href="/searchPage?title=数据仓库">数据仓库</a> <a
                                            href="/searchPage?title=ETL工程师">ETL工程师</a> <a
                                            href="/searchPage?title=数据挖掘">数据挖掘</a> <a
                                            href="/searchPage?title=数据架构师">数据架构师</a> <a
                                            href="/searchPage?title=爬虫工程师">爬虫工程师</a> <a
                                            href="/searchPage?title=数据采集">数据采集</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>技术项目管理</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=项目经理/主管">项目经理/主管</a> <a
                                            href="/searchPage?title=项目助理">项目助理</a> <a
                                            href="/searchPage?title=项目专员">项目专员</a> <a
                                            href="/searchPage?title=实施工程师">实施工程师</a> <a
                                            href="/searchPage?title=实施顾问">实施顾问</a> <a
                                            href="/searchPage?title=需求分析工程师">需求分析工程师</a> <a
                                            href="/searchPage?title=硬件项目经理">硬件项目经理</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>高端技术职位</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=技术经理">技术经理</a> <a
                                            href="/searchPage?title=架构师">架构师</a> <a
                                            href="/searchPage?title=技术总监">技术总监</a> <a
                                            href="/searchPage?title=CTO">CTO</a> <a
                                            href="/searchPage?title=测试经理">测试经理</a> <a
                                            href="/searchPage?title=技术合伙人">技术合伙人</a> <a
                                            href="/searchPage?title=运维总监">运维总监</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>其他技术职位</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=其他技术职位">其他技术职位</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </dl>
                    <dl class="">
                        <dd>
                            <i class="iboss-right-fill"></i>
                            <b>电子/电气/通信</b>
                            <a href="/searchPage?title=电子工程师">电子工程师</a> <a href="/searchPage?title=硬件工程师">硬件工程师</a> <a
                                href="/searchPage?title=嵌入式软件工程师">嵌入式软件工程师</a>
                        </dd>
                        <div class="menu-sub">
                            <p class="menu-article">电子/电气/通信</p>
                            <ul>
                                <li>
                                    <h4>电子/硬件开发</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=电子工程师">电子工程师</a> <a
                                            href="/searchPage?title=硬件工程师">硬件工程师</a> <a
                                            href="/searchPage?title=嵌入式软件工程师">嵌入式软件工程师</a> <a
                                            href="/searchPage?title=FPGA开发">FPGA开发</a> <a
                                            href="/searchPage?title=单片机">单片机</a> <a
                                            href="/searchPage?title=驱动开发工程师">驱动开发工程师</a> <a
                                            href="/searchPage?title=PCB工程师">PCB工程师</a> <a
                                            href="/searchPage?title=电子维修技术员">电子维修技术员</a> <a
                                            href="/searchPage?title=射频工程师">射频工程师</a> <a
                                            href="/searchPage?title=电路设计">电路设计</a> <a
                                            href="/searchPage?title=系统集成">系统集成</a> <a
                                            href="/searchPage?title=光学工程师">光学工程师</a> <a
                                            href="/searchPage?title=DSP开发">DSP开发</a> <a
                                            href="/searchPage?title=ARM开发">ARM开发</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>半导体/芯片</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=集成电路IC设计">集成电路IC设计</a> <a
                                            href="/searchPage?title=数字IC验证工程师">数字IC验证工程师</a> <a
                                            href="/searchPage?title=模拟版图设计工程师">模拟版图设计工程师</a> <a
                                            href="/searchPage?title=芯片测试工程师">芯片测试工程师</a> <a
                                            href="/searchPage?title=DFT工程师">DFT工程师</a> <a
                                            href="/searchPage?title=FAE">FAE</a> <a
                                            href="/searchPage?title=数字前端设计师">数字前端设计师</a> <a
                                            href="/searchPage?title=数字后端工程师">数字后端工程师</a> <a
                                            href="/searchPage?title=模拟IC设计工程师">模拟IC设计工程师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>电气/自动化</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=电气工程师">电气工程师</a> <a
                                            href="/searchPage?title=电气设计工程师">电气设计工程师</a> <a
                                            href="/searchPage?title=自动化">自动化</a> <a
                                            href="/searchPage?title=机电工程师">机电工程师</a> <a
                                            href="/searchPage?title=建筑机电工程师">建筑机电工程师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>技术项目管理</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=项目经理/主管">项目经理/主管</a> <a
                                            href="/searchPage?title=项目助理">项目助理</a> <a
                                            href="/searchPage?title=项目专员">项目专员</a> <a
                                            href="/searchPage?title=实施工程师">实施工程师</a> <a
                                            href="/searchPage?title=实施顾问">实施顾问</a> <a
                                            href="/searchPage?title=需求分析工程师">需求分析工程师</a> <a
                                            href="/searchPage?title=硬件项目经理">硬件项目经理</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>通信</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=通信项目专员">通信项目专员</a> <a
                                            href="/searchPage?title=通信项目经理">通信项目经理</a> <a
                                            href="/searchPage?title=通信技术工程师">通信技术工程师</a> <a
                                            href="/searchPage?title=通信研发工程师">通信研发工程师</a> <a
                                            href="/searchPage?title=无线/射频通信工程师">无线/射频通信工程师</a> <a
                                            href="/searchPage?title=移动通信工程师">移动通信工程师</a> <a
                                            href="/searchPage?title=电信网络工程师">电信网络工程师</a> <a
                                            href="/searchPage?title=数据通信工程师">数据通信工程师</a> <a
                                            href="/searchPage?title=通信测试工程师">通信测试工程师</a> <a
                                            href="/searchPage?title=光通信工程师">光通信工程师</a> <a
                                            href="/searchPage?title=光网络工程师">光网络工程师</a> <a
                                            href="/searchPage?title=通信电源工程师">通信电源工程师</a> <a
                                            href="/searchPage?title=有线传输工程师">有线传输工程师</a> <a
                                            href="/searchPage?title=通信设备工程师">通信设备工程师</a> <a
                                            href="/searchPage?title=核心网工程师">核心网工程师</a> <a
                                            href="/searchPage?title=通信标准化工程师">通信标准化工程师</a> <a
                                            href="/searchPage?title=网络工程师">网络工程师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>销售技术支持</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=售前技术支持">售前技术支持</a> <a
                                            href="/searchPage?title=售后技术支持">售后技术支持</a> <a
                                            href="/searchPage?title=销售技术支持">销售技术支持</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>运维/技术支持</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=运维工程师">运维工程师</a> <a
                                            href="/searchPage?title=系统工程师">系统工程师</a> <a
                                            href="/searchPage?title=技术文档工程师">技术文档工程师</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </dl>
                    <dl class="">
                        <dd>
                            <i class="iboss-right-fill"></i>
                            <b>产品</b>
                            <a href="/searchPage?title=产品经理">产品经理</a> <a href="/searchPage?title=产品专员/助理">产品专员/助理</a> <a
                                href="/searchPage?title=高级产品管理岗">高级产品管理岗</a>
                        </dd>
                        <div class="menu-sub">
                            <p class="menu-article">产品</p>
                            <ul>
                                <li>
                                    <h4>产品经理</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=产品经理">产品经理</a> <a
                                            href="/searchPage?title=产品专员/助理">产品专员/助理</a> <a
                                            href="/searchPage?title=高级产品管理岗">高级产品管理岗</a> <a
                                            href="/searchPage?title=电商产品经理">电商产品经理</a> <a
                                            href="/searchPage?title=AI产品经理">AI产品经理</a> <a
                                            href="/searchPage?title=数据产品经理">数据产品经理</a> <a
                                            href="/searchPage?title=移动产品经理">移动产品经理</a> <a
                                            href="/searchPage?title=金融产品经理">金融产品经理</a> <a
                                            href="/searchPage?title=亚马逊产品开发">亚马逊产品开发</a> <a
                                            href="/searchPage?title=化妆品产品经理">化妆品产品经理</a> <a
                                            href="/searchPage?title=硬件产品经理">硬件产品经理</a> <a
                                            href="/searchPage?title=其他产品职位">其他产品职位</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>游戏策划/制作</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=游戏策划">游戏策划</a> <a
                                            href="/searchPage?title=系统策划">系统策划</a> <a
                                            href="/searchPage?title=游戏数值策划">游戏数值策划</a> <a
                                            href="/searchPage?title=游戏制作人">游戏制作人</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>用户研究</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=用户研究员">用户研究员</a> <a
                                            href="/searchPage?title=用户研究经理">用户研究经理</a> <a
                                            href="/searchPage?title=用户研究总监">用户研究总监</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </dl>
                    <dl class="">
                        <dd>
                            <i class="iboss-right-fill"></i>
                            <b>客服/运营</b>
                            <a href="/searchPage?title=客服专员">客服专员</a> <a href="/searchPage?title=客服主管">客服主管</a> <a
                                href="/searchPage?title=客服经理">客服经理</a>
                        </dd>
                        <div class="menu-sub">
                            <p class="menu-article">客服/运营</p>
                            <ul>
                                <li>
                                    <h4>客服</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=客服专员">客服专员</a> <a
                                            href="/searchPage?title=客服主管">客服主管</a> <a
                                            href="/searchPage?title=客服经理">客服经理</a> <a
                                            href="/searchPage?title=网络客服">网络客服</a> <a
                                            href="/searchPage?title=电话客服">电话客服</a> <a
                                            href="/searchPage?title=售后客服">售后客服</a> <a
                                            href="/searchPage?title=售前客服">售前客服</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>内容运营</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=新媒体运营">新媒体运营</a> <a
                                            href="/searchPage?title=直播运营">直播运营</a> <a
                                            href="/searchPage?title=视频运营">视频运营</a> <a
                                            href="/searchPage?title=内容运营">内容运营</a> <a
                                            href="/searchPage?title=微信运营">微信运营</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>电商运营</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=国内电商运营">国内电商运营</a> <a
                                            href="/searchPage?title=跨境电商运营">跨境电商运营</a> <a
                                            href="/searchPage?title=品类运营">品类运营</a> <a
                                            href="/searchPage?title=淘宝运营">淘宝运营</a> <a
                                            href="/searchPage?title=天猫运营">天猫运营</a> <a
                                            href="/searchPage?title=京东运营">京东运营</a> <a
                                            href="/searchPage?title=拼多多运营">拼多多运营</a> <a
                                            href="/searchPage?title=亚马逊运营">亚马逊运营</a> <a
                                            href="/searchPage?title=亚马逊产品开发">亚马逊产品开发</a> <a
                                            href="/searchPage?title=阿里国际站运营">阿里国际站运营</a> <a
                                            href="/searchPage?title=速卖通运营">速卖通运营</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>业务运营</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=运营助理/专员">运营助理/专员</a> <a
                                            href="/searchPage?title=产品运营">产品运营</a> <a
                                            href="/searchPage?title=用户运营">用户运营</a> <a
                                            href="/searchPage?title=商家运营">商家运营</a> <a
                                            href="/searchPage?title=数据/策略运营">数据/策略运营</a> <a
                                            href="/searchPage?title=社区运营">社区运营</a> <a
                                            href="/searchPage?title=游戏运营">游戏运营</a> <a
                                            href="/searchPage?title=活动运营">活动运营</a> <a
                                            href="/searchPage?title=网站运营">网站运营</a> <a
                                            href="/searchPage?title=内容审核">内容审核</a> <a
                                            href="/searchPage?title=数据标注/AI训练师">数据标注/AI训练师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>线下运营</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=车辆运营">车辆运营</a> <a
                                            href="/searchPage?title=线下拓展运营">线下拓展运营</a> <a
                                            href="/searchPage?title=商场运营">商场运营</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>编辑</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=文案编辑">文案编辑</a> <a
                                            href="/searchPage?title=网站编辑">网站编辑</a> <a
                                            href="/searchPage?title=医学编辑">医学编辑</a> <a
                                            href="/searchPage?title=主编/副主编">主编/副主编</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>高端运营职位</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=运营经理/主管">运营经理/主管</a> <a
                                            href="/searchPage?title=运营总监">运营总监</a> <a
                                            href="/searchPage?title=COO">COO</a> <a
                                            href="/searchPage?title=客服总监">客服总监</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>其他运营职位</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=其他运营职位">其他运营职位</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </dl>
                    <dl class="">
                        <dd>
                            <i class="iboss-right-fill"></i>
                            <b>销售</b>
                            <a href="/searchPage?title=销售专员">销售专员</a> <a href="/searchPage?title=电话销售">电话销售</a> <a
                                href="/searchPage?title=网络销售">网络销售</a>
                        </dd>
                        <div class="menu-sub">
                            <p class="menu-article">销售</p>
                            <ul>
                                <li>
                                    <h4>销售</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=销售专员">销售专员</a> <a
                                            href="/searchPage?title=电话销售">电话销售</a> <a
                                            href="/searchPage?title=网络销售">网络销售</a> <a
                                            href="/searchPage?title=渠道销售">渠道销售</a> <a
                                            href="/searchPage?title=大客户代表">大客户代表</a> <a
                                            href="/searchPage?title=客户经理">客户经理</a> <a
                                            href="/searchPage?title=BD经理">BD经理</a> <a
                                            href="/searchPage?title=客户代表">客户代表</a> <a
                                            href="/searchPage?title=销售工程师">销售工程师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>销售管理</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=销售经理">销售经理</a> <a
                                            href="/searchPage?title=销售总监">销售总监</a> <a
                                            href="/searchPage?title=销售VP">销售VP</a> <a
                                            href="/searchPage?title=团队经理">团队经理</a> <a
                                            href="/searchPage?title=城市经理">城市经理</a> <a
                                            href="/searchPage?title=区域总监">区域总监</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>销售行政/商务</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=销售助理">销售助理</a> <a
                                            href="/searchPage?title=销售运营">销售运营</a> <a
                                            href="/searchPage?title=商务专员">商务专员</a> <a
                                            href="/searchPage?title=商务经理">商务经理</a> <a
                                            href="/searchPage?title=商务总监">商务总监</a> <a
                                            href="/searchPage?title=客户成功">客户成功</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>外贸销售</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=外贸业务员">外贸业务员</a> <a
                                            href="/searchPage?title=外贸经理">外贸经理</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>课程销售</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=课程顾问">课程顾问</a> <a
                                            href="/searchPage?title=招生顾问">招生顾问</a> <a
                                            href="/searchPage?title=留学顾问">留学顾问</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>汽车销售</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=汽车销售">汽车销售</a> <a
                                            href="/searchPage?title=汽车配件销售">汽车配件销售</a> <a
                                            href="/searchPage?title=二手车评估师">二手车评估师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>房地产销售/招商</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=置业顾问">置业顾问</a> <a
                                            href="/searchPage?title=地产中介">地产中介</a> <a
                                            href="/searchPage?title=物业招商管理">物业招商管理</a> <a
                                            href="/searchPage?title=房地产销售总监">房地产销售总监</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>服务业销售</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=服装导购">服装导购</a> <a
                                            href="/searchPage?title=珠宝销售">珠宝销售</a> <a
                                            href="/searchPage?title=美容顾问">美容顾问</a> <a
                                            href="/searchPage?title=化妆品导购">化妆品导购</a> <a
                                            href="/searchPage?title=会籍顾问">会籍顾问</a> <a
                                            href="/searchPage?title=瘦身顾问">瘦身顾问</a> <a
                                            href="/searchPage?title=旅游顾问">旅游顾问</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>医疗销售</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=医药代表">医药代表</a> <a
                                            href="/searchPage?title=医疗器械销售">医疗器械销售</a> <a
                                            href="/searchPage?title=药店店员">药店店员</a> <a
                                            href="/searchPage?title=药店店长">药店店长</a> <a
                                            href="/searchPage?title=医美咨询">医美咨询</a> <a
                                            href="/searchPage?title=健康顾问">健康顾问</a> <a
                                            href="/searchPage?title=口腔咨询师">口腔咨询师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>广告/会展销售</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=广告销售">广告销售</a> <a
                                            href="/searchPage?title=会展活动销售">会展活动销售</a> <a
                                            href="/searchPage?title=会议活动销售">会议活动销售</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>金融销售</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=理财顾问">理财顾问</a> <a
                                            href="/searchPage?title=保险顾问">保险顾问</a> <a
                                            href="/searchPage?title=信用卡销售">信用卡销售</a> <a
                                            href="/searchPage?title=证券经纪人">证券经纪人</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>其他销售职位</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=其他销售职位">其他销售职位</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </dl>
                    <dl class="">
                        <dd>
                            <i class="iboss-right-fill"></i>
                            <b>人力/行政/法务</b>
                            <a href="/searchPage?title=人力资源专员/助理">人力资源专员/助理</a> <a
                                href="/searchPage?title=人力资源经理/主管">人力资源经理/主管</a> <a
                                href="/searchPage?title=人力资源总监">人力资源总监</a>
                        </dd>
                        <div class="menu-sub">
                            <p class="menu-article">人力/行政/法务</p>
                            <ul>
                                <li>
                                    <h4>人力资源</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=人力资源专员/助理">人力资源专员/助理</a> <a
                                            href="/searchPage?title=人力资源经理/主管">人力资源经理/主管</a> <a
                                            href="/searchPage?title=人力资源总监">人力资源总监</a> <a
                                            href="/searchPage?title=招聘">招聘</a> <a href="/searchPage?title=HRBP">HRBP</a>
                                        <a href="/searchPage?title=培训">培训</a> <a href="/searchPage?title=员工关系">员工关系</a>
                                        <a href="/searchPage?title=组织发展">组织发展</a> <a
                                            href="/searchPage?title=企业文化">企业文化</a> <a
                                            href="/searchPage?title=薪酬绩效">薪酬绩效</a> <a
                                            href="/searchPage?title=猎头顾问">猎头顾问</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>行政</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=行政专员/助理">行政专员/助理</a> <a
                                            href="/searchPage?title=行政经理/主管">行政经理/主管</a> <a
                                            href="/searchPage?title=行政总监">行政总监</a> <a href="/searchPage?title=前台">前台</a>
                                        <a href="/searchPage?title=后勤">后勤</a> <a href="/searchPage?title=经理助理">经理助理</a>
                                        <a href="/searchPage?title=文员">文员</a> <a href="/searchPage?title=企业党建">企业党建</a>
                                        <a href="/searchPage?title=档案管理">档案管理</a> <a
                                            href="/searchPage?title=商务司机">商务司机</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>法律服务</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=法务专员/助理">法务专员/助理</a> <a
                                            href="/searchPage?title=法务经理/主管">法务经理/主管</a> <a
                                            href="/searchPage?title=法务总监">法务总监</a> <a
                                            href="/searchPage?title=法律顾问">法律顾问</a> <a href="/searchPage?title=律师">律师</a>
                                    </div>
                                </li>
                                <li>
                                    <h4>其他职能职位</h4>
                                    <div class="text">
                                        <a href="/searchPage?title=其他职能职位">其他职能职位</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </dl>

                </div>
                <div class="job-menu-page" data-size="7" data-pages="4">
                    <span class="menu-page-info"><em class="menu-current-page">1</em> / 1</span>
                    <div class="menu-page-controller">
                        <span class="menu-page-btn menu-page-prev" ka="category_page_previous"><i
                                class="iboss-left-fill"></i></span>
                        <span class="menu-page-btn menu-page-next" ka="category_page_next"><i
                                class="iboss-right-fill"></i></span>
                    </div>
                </div>
            </div>

        </div>
        <div class="home-other">
        大量岗位，大量公司火热招聘中
        </div>
    </div>
</template>

<style scoped lang='scss'>
.home-other{
    color: white;
    font-size: 30px;
    line-height: 280px;
    text-align: center;
    // background-image: url("../../assets/image/pexels-fauxels-3184465.jpg");
    background-color: rgba(156, 252, 220, 0.795);
    width: 784px;
    height: 338px;
    margin-left: 5px;
    border-radius: 20px;
}
.container {
    display: flex;
    position: relative;
    margin: 0 auto;
    margin-left: calc((100vw - 1200px)/2);

    .home-sider {
        position: relative
    }

    .menu-sub {
        overflow: scroll;

        &::-webkit-scrollbar {
            display: none;
        }
    }
}

@import url('../../assets/homeMain.css');
</style>