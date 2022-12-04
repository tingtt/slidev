<template>
    <div class="absolute z-50 h-[0.3rem] bottom-0 left-0 right-0 flex justify-center">
        <div class="w-full relative h-full bg-amber-500 overflow-hidden">
            <span class="absolute h-full bg-amber-300 transition-all duration-300" :style="style_current"></span>
        </div>
    </div>
</template>

<script lang="ts">
  export default {
    name: "Progress",
    props: [ 'current', 'total' ],
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