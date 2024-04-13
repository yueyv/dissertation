import { createMemoryHistory, createRouter, createWebHistory } from 'vue-router'
import { message } from 'ant-design-vue';
// MARK SSR控制
// const localStorage=import.meta.env.SSR?undefined:window.localStorage
// SSR
function isAuthenticated() {
  return import.meta.env.SSR ? true : localStorage.getItem("token") !== null;
}
const routes = [
  {
    path: '/',
    alias: "/homePage",
    name: 'homePage',
    meta: {
      title: '云聘',
      description: '这是一个招聘网站的seo'
    },
    component: () => import('../page/homePage.vue')
  },
  {
    path: '/commendPage',
    name: 'commendPage',
    meta: {
      title: '推荐页面',
      description: '这是一个招聘网站的推荐页面'
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
    meta: {
      title: '错误页面'
    },
    component: () => import("../error/errorPage.vue")
  },
  {
    path: '/login',
    // alias:'login',
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
    // alias:'register',
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
      title: '招聘页面'
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
  {
    path: '/jobPage/:id',
    name: 'jobPage',
    meta: {
      title: '职业详细页面'
    },
    component: () => import('../page/jobPage.vue')
  },
  {
    path: '/editJobPage/:id',
    name: 'editJobPage',
    meta: {
      title: '编辑职业详细页面'
    },
    component: () => import('../page/editJobPage.vue'),
    beforeEnter: (to, from, next) => {
      // 检查用户是否有权限
      if (isAuthenticated()) {
        next();
      } else {
        import.meta.env.SSR ? false : message.warning("请先登录");

        next("/login");
      }
    }
  },
  {
    path: '/bringInPage/apply',
    name: 'applyBringInPage',
    meta: {
      title: '申请招聘页面'
    },
    component: () => import('../page/applyBringInPage.vue')
  },
  {
    path: '/bringInPage/myEdit',
    name: 'myEditPage',
    meta: {
      title: '管理招聘页面'
    },
    component: () => import('../page/myEditPage.vue')
  },

  // MARK鉴权
  {
    path: '/editPersonMesPage',
    name: 'editPersonMesPage',
    meta: {
      title: '修改信息',
      permission: true
    },
    component: () => import('../page/editPersonMesPage.vue'),
    beforeEnter: (to, from, next) => {
      // 检查用户是否有权限
      if (isAuthenticated()) {
        next();
      } else {
        import.meta.env.SSR ? false : message.warning("请先登录");

        next("/login");
      }
    }
  },
  {
    path: '/applicantPage/:id',
    name: 'applicantPage',
    meta: {
      title: '应聘人员详细页面'
    },
    component: () => import('../page/applicantPage.vue'),
    beforeEnter: (to, from, next) => {
      // 检查用户是否有权限
      if (isAuthenticated()) {
        next();
      } else {
        import.meta.env.SSR ? false : message.warning("请先登录");

        next("/login");
      }
    }
  },
  {
    path: '/chatFindPage/:id',
    name: 'chatFindPage',
    meta: {
      title: '招聘人员详细页面'
    },
    component: () => import('../page/chatFindPage.vue'),
    beforeEnter: (to, from, next) => {
      // 检查用户是否有权限
      if (isAuthenticated()) {
        next();
      } else {
        import.meta.env.SSR ? false : message.warning("请先登录");
        next("/login");

      }
    }
  },
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
      if (isAuthenticated()) {
        next();
      } else {
        import.meta.env.SSR ? false : message.warning("请先登录");
        next("/login");

      }
    }
  },
  {
    path: '/videoChatPage',
    name: 'videoChatPage',
    meta: {
      title: '视频面试页面',
      permission: true,
      videoChat:true
    },
    component: () => import('../page/videoChatPage.vue'),
    beforeEnter: (to, from, next) => {
      // 检查用户是否已登录
      if (isAuthenticated()) {
        next();
      } else {
        import.meta.env.SSR ? false : message.warning("请先登录");
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
      // IM 鉴权
      if (isAuthenticated()) {
        next();
      } else {
        import.meta.env.SSR ? false : age.warning("请先登录");
        next("/login");

      }
    }
  },
  {
    path: '/uploadResume',
    name: 'uploadResume',
    meta: {
      title: '上传简历',
      permission: true
    },
    component: () => import('../page/uploadResume.vue'),
    beforeEnter: (to, from, next) => {
      // 检查用户是否已登录
      // IM 鉴权
      if (isAuthenticated()) {
        next();
      } else {
        import.meta.env.SSR ? false : age.warning("请先登录");
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
  // , {
  //   path: '/adminLogin',
  //   name: 'adminLogin',
  //   meta: {
  //     title: '管理员登录',
  //     permission: true,
  //     admin: true
  //   },
  //   component: () => import('../components/login/admin.vue'),
  // },
  //   {
  //     path: '/admin',
  //     name: 'admin',
  //     meta: {
  //       title: '后台管理',
  //       permission: true,
  //       admin: true
  //     },
  //     component: () => import('../admin/admin.vue'),
  // children: [
  //   {
  //     path: '/one',
  //     component: () => import('../admin/children/test.vue'),
  //   },

  // ],
  //   beforeEnter: (to, from, next) => {
  //     // 检查用户权限
  //     if (sessionStorage.getItem("admin") && JSON.parse(sessionStorage.getItem("admin")) == "yueyv") {
  //       next();
  //     } else {
  //       message.warning("权限不足");
  //       next("/adminLogin");
  //     }
  //   }
  // },

]
export const router = createRouter({
  history: import.meta.env.SSR ? createMemoryHistory() : createWebHistory(),
  routes,
})
// 路由守卫
// SPA 
// router.beforeEach((to, from, next) => {
//   const pageTitle = to.meta.title;
//   if (pageTitle) {
//     document.title = pageTitle;
//   }
//   // 检查目标路由是否存在
//   if (router.hasRoute(to.name)) {
//     next(); // 继续路由导航
//   } else {
//     console.log('errorPage');
//     document.title = "错误页面";
//     next({ name: 'errorPage' }); // 跳转到错误页面
//   }
// });
// SSR版本 路由有pagecontent完成，可省略
router.beforeEach((to, from, next) => {
  const pageTitle = to.meta.title;
  if (pageTitle) {
    import.meta.env.SSR ? true : document.title = pageTitle;;
  }
  // 检查目标路由是否存在
  if (router.hasRoute(to.name)) {
    next(); // 继续路由导航
  } else {
    console.log('errorPage');
    next({ name: 'errorPage' }); // 跳转到错误页面
  }
});

