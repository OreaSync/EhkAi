<template>
   <!-- Тута кароче сам диалог между пользователем и ИИ -->
    <div>
      <div v-for="(message, index) in messages" :key="index">
        <div v-if="message.role === 'user'" class="flex flex-row-reverse items-center mb-1">
          <h2 class="ml-2">User</h2>
          <div class="border p-1 rounded-xl flex items-center justify-center">
            <Icon icon="ri:user-3-line" width="1.5em" height="1.5em" />
          </div>
        </div>
        <div v-if="message.role === 'ai'" class="flex items-center mb-1">
          <div class="border p-1 rounded-xl flex items-center justify-center">
            <Icon icon="mingcute:ai-line" width="1.5em" height="1.5em" />
          </div>
          <h2 class="ml-2">{{ message.modelName }}</h2>
        </div>
        <p :class="{ 'w-2/4 ml-auto text-right break-words': message.role === 'user', 'w-2/4': message.role === 'ai' }">
          {{ message.content }}
        </p>
      </div>
    </div>
  </template>
  
  <script setup>
  import { defineProps } from 'vue';
  
  const props = defineProps({
  messages: Array
});
  </script>
  