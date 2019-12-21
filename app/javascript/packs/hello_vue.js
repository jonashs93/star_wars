import Vue from 'vue'
import App from '../app.vue'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'
import Vuetable from 'vuetable-2'

Vue.use(VueResource)
Vue.use(TurbolinksAdapter)
Vue.use(Vuetable)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})
