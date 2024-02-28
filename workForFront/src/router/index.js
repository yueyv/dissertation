import { createRouter,createWebHistory} from 'vue-router'
import {message} from 'ant-design-vue';

const routes = [
    {
        path: '/',
        alias:"/homePage",
        name: 'homePage',
        meta: {
            title: '云聘'
        },
        component: () => import('../page/homePage.vue')
    }, 
    {
        path: '/commendPage',
        name: 'commendPage',
        meta: {
            title: '推荐页面'
        },
        component: () => import('../page/commendPage.vue')
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
    {
        path: '/faqPage',
        name: 'faqPage',
        meta: {
            title: 'FAQ页面'
        },
        component: () => import('../page/faqPage.vue')
    }, 
    {
        path: '/bringInPage',
        name: 'bringInPage',
        meta: {
            title: '求职页面'
        },
        component: () => import('../page/bringInPage.vue')
    }, 
    {
        path: '/huntJobPage',
        name: 'huntJobPage',
        meta: {
            title: '搜索页面'
        },
        component: () => import('../page/huntJobPage.vue')
    }, 
// MARK鉴权
{
    path: '/chatPage',
    name: 'chatPage',
    meta: {
      title: '聊天页面',
      permission: true
    },
    component: () => import('../page/chatPage.vue'),
         beforeEnter: (to, from, next) => {
        // 检查用户是否已登录
        if (localStorage.getItem("token")) {
          next();
        } else {
          message.warning("请先登录");
          next("/login");
        }
      }
},
{
    path: '/personalPage',
    name: 'personalPage',
    meta: {
      title: '个人页面',
      permission: true
    },
    component: () => import('../page/personalPage.vue'),
    beforeEnter: (to, from, next) => {
        // 检查用户是否已登录
        if (localStorage.getItem("token")) {
          next();
        } else {
          message.warning("请先登录");
          next("/login");
        }
      }
  },
  {
      path: '/test',
      name: 'testPage',
      meta: {
        title: '测试页面',
        permission: true
      },
      component: () => import('../page/testPage.vue'),
      // IM 鉴权方法
      // beforeEnter: (to, from, next) => {
      //   console.log(233);
      //   // 检查用户是否已登录
      //   if (sessionStorage.getItem("token")) {
      //     next();
      //   } else {
      //     message.warning("请先登录");
      //     next("/login");
      //   }
      // }
    }
   
]
export const router = createRouter({
    history: createWebHistory(),
    routes,
})
// 路由守卫
router.beforeEach((to, from, next) => {
    const pageTitle = to.meta.title;
    if (pageTitle) {
      document.title = pageTitle;
    }
    // 检查目标路由是否存在
    if (router.hasRoute(to.name)) {
      next(); // 继续路由导航
    } else {
      console.log('errorPage');
      document.title = "错误页面";
      next({ name: 'errorPage' }); // 跳转到错误页面
    }
  });

