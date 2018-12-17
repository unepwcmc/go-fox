<template>
<div class="nav__wrapper">
  <div id="scroll-nav" class="nav--side">

    <div id='scroll-nav-toggle' @click="toggleDropdown" class="nav__dropdown-toggle gutters flex flex-v-center flex-h-between">
      <span>Sections on this page</span>
      <i class='material-icons nav__icon'>{{ dropIcon }}</i>
    </div>

    <ul id="nav-list" v-show="showItems" class="ul-unstyled nav__ul">
      <li 
        v-for="item in navArray" 
        :id="getLinkId(item)" 
        class="scroll-nav__item nav__li flex flex-v-center flex-h-between"
        @click.prevent="scroll(item)">
        <a 
          :title="'See events in ' + item" 
          class="nav__link">{{ item }}</a>
        <i class="material-icons nav__icon">chevron_right</i>
      </li>
    </ul>
  </div>
</div>
</template>

<script>
  import { mixinResponsive } from '../../mixins/mixin-responsive.js'
  import { nameToId, addStickyStyling, removeStickyStyling } from '../../helpers/application-helpers.js'
  import { eventHub } from '../../admin.js'
  import ScrollMagic from 'scrollmagic'

  export default { 
    name: 'scroll-nav',

    mixins: [ mixinResponsive ],

    props: {
      navArray: {
        required: true,
        type: Array
      }
    },

    data () {
      return {
        isActive: false,
        windowWidth: 0,
        triggerHeight: 0
      }
    },

    created () {
      window.addEventListener('click', e => {
        if (this.isActive && !this.$el.contains(e.target)) {
          this.isActive = false
        }   
      })
    },

    mounted () {
      // set the initial window width
      this.windowWidth = window.innerWidth
      addStickyStyling(this.stickyId, 0, this.initialOffset)

      // recalculate scene heights when the window is resized
      eventHub.$on('window-resized', this.windowResized)

      // initiate scroll magin handlers
      this.scrollMagicHandlers()

      // monitor window resizing
      window.onresize = this.windowResized
    },

    computed: {
      showItems () {
        return !this.isSmall() || this.isActive
      },
      dropIcon () {
        return this.showItems ? 'expand_less' : 'expand_more'
      },
      triggerOffset () {
        return this.isSmall() ? this.triggerHeight : 0
      },
      stickyId () {
        return this.isSmall() ? 'scroll-nav' : 'nav-list'
      },
      initialOffset () {
        if(this.isSmall()) { return 196 }

        return this.isLarge() ? 322 : 226
      }
    },

    methods: {
      getLinkId (item) {
        return nameToId(`link-${item}`)
      },

      getSectionId (item) {
        return nameToId(`section-${item}`)
      },

      toggleDropdown () {
        this.isActive = !this.isActive
      },

      setTriggerHeight () {
        this.triggerHeight = this.isSmall() ? $('#scroll-nav-toggle').innerHeight() : 0
      },

      // scroll down to the section of the page which corresponds to the
      // link that has been clicked
      scroll (item) {
        if (this.isSmall()) { this.toggleDropdown() }

        const offset = document.getElementById(this.getSectionId(item)).offsetTop
        window.scrollTo({ top: offset - this.triggerOffset, behavior: 'smooth' })
      },

      // add scroll magic event listener for each nav item
      // so that the nav items change active state when scrolling
      // through different sections on the page
      scrollMagicHandlers () {
        let navScrollMagic = new ScrollMagic.Controller()
        let scrollMagicScenes = []

        // add scene for each item in the nav
        this.navArray.forEach(link => {
          let scene = {}
          scene.id = link

          scene.scene = new ScrollMagic.Scene({ 
            triggerElement: '#' + this.getSectionId(link), 
            triggerHook: 'onLeave'
          })
          .offset(-this.triggerOffset)
          .setClassToggle('#' + this.getLinkId(link), 'scroll-nav__link--active')
          .addTo(navScrollMagic)

          scrollMagicScenes.push(scene)
        })

        this.scrollMagicScenes = scrollMagicScenes
      },

      updateScrollMagicDurations () {
        // update the scene durations (section div heights)
        this.scrollMagicScenes.forEach(scene => {
          let section = document.getElementById(this.getSectionId(scene.id))
          let height = 0


          if(section) height = section.clientHeight

          scene.scene.duration(height)
        })
      },

      windowResized () {
        // when the window width is resized the heights of the sticky bars and
        // sections will change so update js accordingly
        const newWidth = window.innerWidth

        if(newWidth > this.windowWidth || newWidth < this.windowWidth) {
          this.updateScrollMagicDurations()

          this.windowWidth = newWidth
        }
      }
    },

    watch: {
      stickyId (newId, oldId) {
        removeStickyStyling(oldId)
        addStickyStyling(newId, 0, this.initialOffset)
        $(document).scroll()
        this.setTriggerHeight()
      },
      initialOffset (offset) {
        removeStickyStyling(this.stickyId)
        addStickyStyling(this.stickyId, 0, offset)
        $(document).scroll()
      }
    }
  }
</script>
