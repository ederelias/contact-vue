<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-3"> <Sidebar @search="handleSearch" @sort="handleSort" /></div>
      <div class="col-md-9">
        <Header />
        <ContactList :contacts="filteredContacts" />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref, computed } from 'vue';
import axios from 'axios';
import Header from './components/HeaderLayout.vue';
import Sidebar from './components/SidebarLayout.vue';
import ContactList from './components/ContactList.vue';
import {Contact} from "@/types/Contact";

export default defineComponent({
  components: {
    Header,
    Sidebar,
    ContactList,
  },
  setup() {
    const contacts = ref<Contact[]>([]);
    const searchTerm = ref('');
    const sortBy = ref('');

    onMounted(async () => {
      try {
        const response = await axios.get('https://jsonplaceholder.typicode.com/users');
        contacts.value = response.data;
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    });

    const handleSearch = (term: string) => {
      searchTerm.value = term;
    };

    const handleSort = (criteria: string) => {
      sortBy.value = criteria;
    };

    const filteredContacts = computed((): Contact[] => {
      let filtered =  [...contacts.value];

      if (searchTerm.value) {
        const term = searchTerm.value.toLowerCase();
        filtered = filtered.filter((contact) =>
            Object.values(contact).some((value) =>
                String(value).toLowerCase().includes(term)
            )
        );
      }

      if (sortBy.value) {
        const criteria = sortBy.value;
        filtered.sort((a, b) => {
          const getValue = (contact: Contact): string => {
            if (criteria in contact) {
              const value = contact[criteria as keyof Contact];
              return String(value).toLowerCase();
            }
            return '';
          };

          const valueA = getValue(a);
          const valueB = getValue(b);

          return valueA.localeCompare(valueB);
        });
      }
      return filtered;
    });

    return {
      contacts,
      filteredContacts,
      handleSearch,
      handleSort,
    };
  },
});
</script>
