// libraries
import Vue from 'vue/dist/vue.esm'

// store
import store from './store/store.js'

// vue components
import Accordion from './components/accordion/Accordion.vue'
import AccordionItem from './components/accordion/AccordionItem.vue'
import Carousel from './components/carousel/Carousel.vue'
import Slide from './components/carousel/Slide.vue'
import PageItem from './components/pagination/PageItem.vue'
import PaginationButton from './components/pagination/PaginationButton.vue'
import ProgressBar from './components/pagination/ProgressBar.vue'
import Popup from './components/popup/Popup.vue'
import Checkboxes from './components/form_fields/Checkboxes.vue'
import Disabler from './components/form_fields/Disabler.vue'
import RadioButtons from './components/form_fields/RadioButtons.vue'
import TextInput from './components/form_fields/TextInput.vue'
import SelectBox from './components/form_fields/SelectBox.vue'
import SimpleModal from './components/modals/SimpleModal.vue'
import MultipleSelectBox from './components/form_fields/MultipleSelectBox.vue'
import NavBurger from './components/nav/NavBurger.vue'
import NavLink from './components/nav/NavLink.vue'
import NavScroll from './components/scroll_nav/NavScroll.vue'
import Submit from './components/form_fields/Submit.vue'
import Tabs from './components/tabs/Tabs.vue'
import Tab from './components/tabs/Tab.vue'
import ValidationMessage from './components/form_fields/ValidationMessage.vue'
import { initializeEventHandling } from './helpers/application-helpers.js';

// create event hub and export so that it can be imported into .vue files
export const eventHub = new Vue()

initializeEventHandling()

// create vue instance and attach to the DOM
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#v-app',
    store,
    components: { 
      Accordion,
      AccordionItem,
      Carousel,
      Slide, 
      Popup, 
      PageItem, 
      PaginationButton, 
      ProgressBar, 
      Checkboxes,
      Disabler,
      RadioButtons, 
      TextInput, 
      SelectBox,
      SimpleModal,
      MultipleSelectBox, 
      NavBurger,
      NavLink,
      NavScroll,
      Submit,
      Tabs,
      Tab,
      ValidationMessage
    }
  })
})
