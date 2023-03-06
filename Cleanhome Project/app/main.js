import App from './App'

// #ifndef VUE3
import Vue from 'vue'
Vue.config.productionTip = false


import store from '@/store'

// 引入TuniaoUI提供的vuex简写方法
let vuexStore = require('@/store/$tn.mixin.js')
Vue.mixin(vuexStore)

import uView from 'uview-ui'
Vue.use(uView)

// 引入全局TuniaoUI
import TuniaoUI from 'tuniao-ui'
Vue.use(TuniaoUI)

App.mpType = 'app'
const app = new Vue({
    ...App,
	store
})


import { ideautil, yewuutil } from '@/common/commontools.js'
uni.itool = ideautil
uni.ytool = yewuutil
// 引入请求封装，将app参数传递到配置中
require('./common/config/request.js')(app)

app.$mount()
// #endif

// #ifdef VUE3
import { createSSRApp } from 'vue'
export function createApp() {
  const app = createSSRApp(App)
  return {
    app
  }
}
// #endif