import { createRouter,createWebHistory} from 'vue-router'


const routes = [
    {
        path: '/',
        name: 'homePage',
        meta: {
            title: '云聘'
        },
        component: () => import('../page/homePage.vue')
    }, 
    {
        path: '/errorPage',
        name: 'errorPage',
        meta:{
            title:'错误页面'
        },
        component: ()=>import("../error/errorPage.vue")
      },
   
]
export const router = createRouter({
    history: createWebHistory(),
    routes,
})
// 路由守卫
router.beforeEach((to, from) => {
    // 检查目标路由是否存在
    if (to.name && router.hasRoute(to.name)) {
        return true;
    } else {
        console.log('errorPage');
        return { name: 'errorPage' };
    }
});

