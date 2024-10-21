<!-- src/components/AppHeader.vue -->
<template>
  <header>
    <nav>
      <router-link to="/">Home</router-link>
    </nav>
    <SearchForm />
  </header>
</template>

<script>
import SearchForm from './SearchForm.vue'

export default {
  name: 'AppHeader',
  components: {
    SearchForm
  }
}
</script>

<style scoped>
/* Adicione seus estilos aqui */
</style>
