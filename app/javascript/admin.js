import Vue from 'vue/dist/vue.esm'

import store from './store/store.js'
import Accordion from './components/accordion/Accordion.vue'
import AccordionItem from './components/accordion/AccordionItem.vue'
import Carousel from './components/carousel/Carousel.vue'
import Slide from './components/carousel/Slide.vue'
import PageItem from './components/pagination/PageItem.vue'
import PaginationButton from './components/pagination/PaginationButton.vue'
import Popup from './components/popup/Popup.vue'

// create event hub and export so that it can be imported into .vue files
export const eventHub = new Vue()

// create vue instance and attach to the DOM
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#v-app',
    store,
    components: { Accordion, AccordionItem, Carousel, Slide, Popup, PageItem, PaginationButton}
  })
})
