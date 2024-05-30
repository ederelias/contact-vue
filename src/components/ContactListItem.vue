<template>
  <div class="d-flex justify-content-between align-items-center">
    <div>
      <h5>{{ contact.name }}</h5>
      <p class="text-muted">{{ contact.email }}</p>
    </div>
    <button class="btn btn-primary btn-sm" @click="showFullDetails = !showFullDetails">
      {{ showFullDetails ? 'Less' : 'More' }}
    </button>
  </div>

  <div v-if="showFullDetails" class="mt-3">
    <p><strong>Username:</strong> {{ contact.username }}</p>
    <p><strong>Phone:</strong> {{ contact.phone }}</p>
    <p><strong>Address:</strong> {{ contact.address.street }}</p>
    <p><strong>City:</strong> {{ contact.address.city  }}</p>
    <p><strong>Company:</strong> {{ contact.company.name }}</p>


  </div>
</template>

<script lang="ts">
import { defineComponent, PropType, ref } from 'vue';
import { Contact } from '@/types/Contact'; // Assuming you'll create a Contact type

export default defineComponent({
  props: {
    contact: {
      type: Object as PropType<Contact>,
      required: true,
    },
  },
  setup() {
    const showFullDetails = ref(false);
    return { showFullDetails };
  },
});
</script>
