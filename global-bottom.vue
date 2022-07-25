<template>
  <Progress
    v-if="$slidev.nav.currentPage !== 1 && $slidev.nav.currentLayout!== 'end'"
    :current="$slidev.nav.currentPage"
    :total="$slidev.nav.total"
  />
</template>

<script lang="ts">
  export default {
    name: "Progress",
    computed: {
      style_current() {
        return {
          width: `${100 / this.total}%`,
          left: `${100 / this.total * (this.current - 1)}%`,
        }
      }
    }
  };
</script>