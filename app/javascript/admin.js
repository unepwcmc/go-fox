import Vue from 'vue/dist/vue.esm'

import store from './store/store.js'
import Modal from './components/modal/Modal.vue'
import ModalTrigger from './components/modal/ModalTrigger.vue'
import ModalWrapper from './components/modal/ModalWrapper.vue'
import Popup from './components/popup/Popup.vue'

// create event hub and export so that it can be imported into .vue files
export const eventHub = new Vue()

// create vue instance and attach to the DOM
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#v-app',
    store,
    components: { Modal, ModalTrigger, ModalWrapper, Popup }
  })
})
