<template>
  <aside class="bg-light p-3">
    <!-- Search Bar -->
    <input type="text" class="form-control mb-3" placeholder="Search contacts..." v-model="searchTerm" @input="searchContacts">

    <!-- Sorting Options (optional) -->
    <div class="dropdown mb-3">
      <button class="btn btn-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown">
        Sort by
      </button>
      <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="#" @click.prevent="sortContacts('name')">Name</a></li>
        <li><a class="dropdown-item" href="#" @click.prevent="sortContacts('username')">Username</a></li>
      </ul>
    </div>
  </aside>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  data() {
    return {
      searchTerm: '',
    };
  },
  methods: {
    searchContacts() {
      // Emit an event to notify the parent (App.vue) about the search term
      this.$emit('search', this.searchTerm);
    },
    sortContacts(criteria: string) {
      // Emit an event to notify the parent (App.vue) about the sorting criteria
      this.$emit('sort', criteria);
    },
  },
});
</script>
