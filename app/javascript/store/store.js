import { polyfill } from 'es6-promise'
polyfill()

import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex/dist/vuex.esm'
import { storeModal } from './store-modal.js'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    modal: storeModal
  }
})