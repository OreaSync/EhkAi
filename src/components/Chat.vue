<template>
  <!-- Тут сам диалог между пользователем и ИИ -->
  <div class="px-2 md:px-6 lg:px-10 xl:px-72">
    <div v-for="(message, index) in messages" :key="index">
      <!-- Сообщение от пользователя -->
      <div v-if="message.role === 'user'" class="flex flex-row-reverse items-center mb-1">
        <h2 class="ml-2">User</h2>
        <div class="border-2 p-1 rounded-xl flex items-center justify-center">
          <Icon icon="ri:user-3-line" width="1.5em" height="1.5em" />
        </div>
      </div>

      <!-- Сообщение от ИИ -->
      <div v-if="message.role === 'ai'" class="flex items-center mb-1">
        <div class="border-2 p-1 rounded-xl flex items-center justify-center">
          <Icon icon="mingcute:ai-line" width="1.5em" height="1.5em" />
        </div>
        <h2 class="ml-2">{{ message.modelName }}</h2>
      </div>

      <!-- Контент сообщения от ИИ -->
      <p v-if="message.role === 'ai'" class="w-2/4 mb-16">
        {{ message.content }}
      </p>

      <!-- Сообщение от ИИ с изображением -->
      <div v-if="message.role === 'aiImage'" class="flex items-center mb-1">
        <div class="border-2 p-1 rounded-xl flex items-center justify-center">
          <img v-if="message.aiImage" :src="message.content" alt="AI" class="w-12 h-12 rounded-md" />
          <Icon v-else icon="mingcute:ai-line" width="1.5em" height="1.5em" />
        </div>
        <h2 class="ml-2">{{ message.modelName }}</h2>
      </div>


      <p v-if="message.role === 'user'" class="w-2/4 ml-auto text-right break-words">
        {{ message.content }}
      </p>
      <!-- Контент сообщения с изображением -->
      <p v-if="message.role === 'aiImage'" class="w-2/4  mb-16">
        <img :src="message.content" alt="AI-generated" class="max-w-full rounded-lg" />
      </p>
    
    </div>
  </div>
</template>
   
   <script setup>
 import { Icon } from "@iconify/vue";
   const props = defineProps({
   messages: Array
 });
   </script>
   