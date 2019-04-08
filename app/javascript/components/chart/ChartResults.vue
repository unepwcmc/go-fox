<template>
  <div class="chart">
    <div class="chart__container" :style="`padding-bottom:${containerPaddingBottom}`">
      <svg class="chart__svg" :viewBox="`0 0 ${options.svgWidth} ${options.svgHeight}`" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid">
        <rect x="0" y="0" width="100%" height="100%" fill="#ffffff" stroke="#dedede" stroke-width="2"></rect>

        <g v-for="axis, index in axes" :transform="`translate(0,${config.offsetTop + index*100 + axisLabelShift})`"> 
          <text :x="options.axisStart - 55" y="1" text-anchor="end" fill="#466882" font-weight="bold" :font-size="unscaledFontSizeMedium">{{ axis.graphLabel }}</text>
          <text :x="options.axisStart - 10" text-anchor="end" :font-size="unscaledFontSizeSmall">Less</text>
          <line  :x1="options.axisStart" :y1="-axisLabelShift" :x2="options.axisEnd" :y2="-axisLabelShift" stroke="#466882"/>
          <text :x="options.axisEnd + 10" :font-size="unscaledFontSizeSmall">More</text>
        </g>
        
        <g v-for="line, index in data">
          <path
            :d="getPath(line.dataset)"
            fill="none" 
            :stroke="getColour(line.current_user)" 
            :stroke-width="getWidth(line.current_user)" />
          
          <circle v-if="line.current_user" v-for="datapoint, index in line.dataset" :cx="getXValue(datapoint) + options.axisStart" :cy="config.offsetTop + index*100" r="8" :fill="config.colours.currentUser"></circle>          
          <circle v-for="datapoint, index in line.dataset" :cx="getXValue(datapoint) + options.axisStart" :cy="config.offsetTop + index*100" r="4" :fill="config.colours.default"></circle>
        </g>
      </svg>
    </div>
    <div class="chart__legend">
      <div v-for="axis in axes" class="chart__legend-key">{{ `${axis.graphLabel}) ${axis.legendLabel}`}}</div>
    </div>
  </div>
</template>

<script>
  import {mixinResponsive} from '../../mixins/mixin-responsive'

  export default {
    name: 'chart-results',

    mixins: [mixinResponsive],

    props: {
      data: {
        type: Array,
        required: true
      }
    },

    data () {
      return {
        options: {
          svgWidth: 600,
          svgHeight: 330,
          axisStart: 80,
          axisEnd: 530
        },
        config: {
          offsetTop: 0,
          colours: {
            default: '#59A8D0',
            currentUser: '#466882'
          },
        },
        domain: [-4, 4],
        range: [0],
        axes: [
          { graphLabel: 'A', legendLabel: 'People-centred conservation' },
          { graphLabel: 'B', legendLabel: 'Science-led ecocentrism' },
          { graphLabel: 'C', legendLabel: 'Conservation through capitalism' }
        ],
        axisLabelShift: 4
      }
    },

    created () {
      this.range.push(this.options.axisEnd - this.options.axisStart)
      this.config.offsetTop = (this.options.svgHeight - 200) / 2
    },

    computed: {
      containerPaddingBottom () {
        return this.options.svgHeight/this.options.svgWidth * 100 + '%'
      },

      unscaledFontSizeSmall () {
        return this.isSmall() ? 18 : 12
      },

      unscaledFontSizeMedium () {
        return this.isSmall() ? 24 : 16
      }
    },

    methods: {
      getPath (dataset) {
        const x1 = this.getXValue(dataset[0]) + this.options.axisStart,
          x2 = this.getXValue(dataset[1]) + this.options.axisStart,
          x3 = this.getXValue(dataset[2]) + this.options.axisStart,
          y1 = this.config.offsetTop,
          y2 = this.config.offsetTop + 100,
          y3 = this.config.offsetTop + 200

        return `M ${x1} ${y1} L ${x2} ${y2} L ${x3} ${y3}`
      },

      getXValue (x) {
        const range = this.range[1] - this.range[0],
          domain = this.domain[1] - this.domain[0],
          xPosition = x - this.domain[0]

        return ((range*xPosition)/domain) + this.range[0]
      },

      getColour (currentUser) {
        return currentUser ? this.config.colours.currentUser : this.config.colours.default
      },

      getWidth (currentUser) {
        return currentUser ? 4 : 1
      }
    }
  }
</script>