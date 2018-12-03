<template>
  <div class="chart--results">
    <svg width="100%" height="100%" viewBox="0 0 600 440" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid">
      <rect x="0" y="0" width="100%" height="100%" fill="#ffffff" stroke="#dedede" stroke-width="2"></rect>

      <g v-for="axis, index in axes"> 
        <text x="100" :y="123 + index*100" text-anchor="end" fill="#466882" font-weight="bold">{{ axis.title }}</text>
        <text x="110" :y="123 + index*100" font-size="12">0</text>
        <line  x1="125" :y1="120 + index*100" x2="500" :y2="120 + index*100" stroke="#466882"/>
        <text x="510" :y="123 + index*100" font-size="12">100</text>
      </g>

      

      <!-- <rect x="70" y="380" width="460" height="46" fill="#F5F5F1" /> -->

      <!-- <text v-for="axis, index in axes" :x="70 + index*150" y="403">{{ axis.title }}</text> -->
    </svg>
  </div>
</template>

<script>
  export default {
    name: 'chart-results',

    data () {
      return {
        axes: [
          {
            label: 'a',
            title: 'Capitalism'
          },
          {
            label: 'b',
            title: 'People'
          },
          {
            label: 'c',
            title: 'Nature'
          }
        ],
        data: [0,50,100]
      }
    },

    methods: {
      createSvg () {

      }
    }
  }
</script>