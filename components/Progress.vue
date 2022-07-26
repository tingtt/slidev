<template>
    <div class="absolute z-50 h-[0.5rem] bottom-0 left-0 right-0 flex justify-center">
        <div class="w-full relative h-full bg-green-400 overflow-hidden">
            <span class="absolute h-full bg-gray-500 transition-all duration-300" :style="style_current"></span>
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