<template>
  <ul class="list-group">
    <li v-for="contact in filteredContacts" :key="contact.id" class="list-group-item">
      <ContactListItem :contact="contact" />
    </li>
  </ul>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue';
import ContactListItem from './ContactListItem.vue';
import { Contact } from '@/types/Contact';

export default defineComponent({
  components: {
    ContactListItem
  },
  props: {
    contacts: {
      type: Array as PropType<Contact[]>,
      required: true,
    },
  },
  computed: {
    filteredContacts(): Contact[] {
      // Implement search and sorting logic here based on props received from App.vue
      return this.contacts; // Placeholder, replace with actual filtering
    },
  },
});
</script>
