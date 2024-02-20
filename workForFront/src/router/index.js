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
        path: '/searchPage',
        name: 'searchPage',
        meta: {
            title: '搜索页面'
        },
        component: () => import('../page/searchPage.vue')
    }, 
    {
        path: '/errorPage',
        name: 'errorPage',
        meta:{
            title:'错误页面'
        },
        component: ()=>import("../error/errorPage.vue")
      },
      {
        path: '/login',
        // alias:'/',
        name: '登录',
        meta: {
            title: '登录'
        },
        component: () => import('../components/login/login.vue')
    },
    {
        path: '/loading',
        name: 'loading',
        meta: {
            title: '验证中',
        },
        component: () => import('../components/login/loading.vue')
    },
    {
        path: '/register',
        name: '注册',
        meta: {
            title: '注册'
        },
        component: () => import('../components/login/register.vue')
    },
   
]
export const router = createRouter({
    history: createWebHistory(),
    routes,
})
// 路由守卫
router.beforeEach((to, from) => {
    const pageTitle = to.meta.title;
    if (pageTitle) {
      document.title = pageTitle;
    }
    // 检查目标路由是否存在
    if (to.name && router.hasRoute(to.name)) {
        return true;
    } else {
        console.log('errorPage');
        document.title = "错误页面";
        return { name: 'errorPage' };
    }

});

