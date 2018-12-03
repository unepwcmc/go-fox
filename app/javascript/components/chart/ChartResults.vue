<template>
  <div class="chart--results">
    <svg width="100%" height="100%" :viewBox="`0 0 ${options.svgWidth} ${options.svgHeight}`" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid">
      <rect x="0" y="0" width="100%" height="100%" fill="#ffffff" stroke="#dedede" stroke-width="2"></rect>

      <g v-for="axis, index in axes"> 
        <text :x="options.axisStart - 35" :y="config.offsetTop + 3 + index*100" text-anchor="end" fill="#466882" font-weight="bold">{{ axis }}</text>
        <text :x="options.axisStart - 10" :y="config.offsetTop + 3 + index*100" text-anchor="end" font-size="12">-3</text>
        <line  :x1="options.axisStart" :y1="config.offsetTop + index*100" :x2="options.axisEnd" :y2="config.offsetTop + index*100" stroke="#466882"/>
        <text :x="options.axisEnd + 10" :y="config.offsetTop + 3 + index*100" font-size="12">3</text>
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
</template>

<script>
  export default {
    name: 'chart-results',

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
          axisStart: 160,
          axisEnd: 510
        },
        config: {
          offsetTop: 0,
          colours: {
            default: '#59A8D0',
            currentUser: '#466882'
          },
        },
        domain: [-3, 3],
        range: [0],
        axes: ['Capitalism', 'People', 'Nature']
      }
    },

    created () {
      this.range.push(this.options.axisEnd - this.options.axisStart)
      this.config.offsetTop = (this.options.svgHeight - 200) / 2
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