<script setup>
import { ref, onMounted } from 'vue';
import gsap from "gsap";
import { Icon } from '@iconify/vue';

const isModalVisible = ref(false);
const openModalButton = ref(null);
const modal = ref(null);
const buttonX = ref(null);

const modelType = ref('GPT3.5 Turbo');
const emit = defineEmits(['selectModel']);

function handleClick(model) {
  modelType.value = model;
  emit('selectModel', model);

  const listItems = document.querySelectorAll('li');
  
  const selectedListItem = Array.from(listItems).find((item) => item.textContent.trim() === model);
  
  listItems.forEach((item) => {
    if (item === selectedListItem) {
      gsap.to(item, {
        scale: 0.95,
        duration: 0.3,
      });
    } else {
      gsap.to(item, {
        scale: 1,
        duration: 0.3,
      });
    }
  });
}

const chatModels = [
  { name: 'GPT3.5 Turbo' },
  { name: 'GPT-4o Mini' },
  { name: 'GPT-4 Nexra' },
  { name: 'GPT-3.5 Turbo Nexra' },
  { name: 'Command-R+' },
  { name: 'Qwen' },
  { name: 'Blackbox' },
  { name: 'Gemini Pro' },
  { name: 'Gemini' },
];

const imageModels = [
    { name: 'Flux' },
    { name: 'Kandinsky' },
    { name: 'NSFW-XL' },
];

const toggleModal = () => {
  if (isModalVisible.value) {
    gsap.to(modal.value, {
      opacity: 0,
      scale: 0.9,
      duration: 0.3,
      onComplete: () => {
        isModalVisible.value = false;
      }
    });
  } else {
    isModalVisible.value = true;
    gsap.fromTo(modal.value, 
      { opacity: 0, scale: 0.9 },
      { opacity: 1, scale: 1, duration: 0.3 }
    );
  }
};

const enterXAnim = () => {
    gsap.to(
        buttonX.value,
        { rotate: 90, duration: 0.3 }
    );
};

const leaveXAnim = () => {
    gsap.to(
        buttonX.value,
        { rotate: 0, duration: 0.3 }
    );
};

const enterButtonAnim = () => {
    gsap.to(
        openModalButton.value,
        { scale: 0.95, duration: 0.3 }
    );
};

const leaveButtonAnim = () => {
    gsap.to(
        openModalButton.value,
        { scale: 1, duration: 0.3 }
    );
};

onMounted(() => {
    gsap.fromTo(
        openModalButton.value,
        { opacity: 0 },
        { opacity: 1, y: 8, duration: 1 }
    );
});
</script>

<template>
    <div class="flex justify-center items-center">
        <a @mouseenter="enterButtonAnim" @mouseleave="leaveButtonAnim" ref="openModalButton" @click="toggleModal" class="cursor-pointer px-4 py-2 text-[#FFB88C] rounded-xl border-2 bg-[#111111] border-[#1b1b1bec]">
            Models
        </a>
    </div>
    <div v-show="isModalVisible" class="fixed inset-0 flex justify-center items-center z-50 backdrop-blur-md py-2">
        <div ref="modal" class="w-[90%] lg:h-[90%] p-3 z-40 rounded-xl bg-[#1a1919] overflow-y-auto max-h-full">
            <h1 class="flex justify-between items-center text-[1.4em] text-[#FFB88C]">
                <span>Select a model</span>
                <div @mouseenter="enterXAnim" @mouseleave="leaveXAnim" ref="buttonX">
                    <Icon class="cursor-pointer" @click="toggleModal" icon="ic:round-close" width="1.2em" height="1.2em" style="color: white" />
                </div>
            </h1>
            <div class="grid grid-cols-1 lg:grid-cols-5 gap-2">
                <ul>
                    <h2 class="text-[1.175em] mb-1 flex justify-center items-center border-b-2 border-[#363636]">Chat</h2>
                    <li ref="listItem" @click="handleClick(model.name)" class="flex justify-between cursor-pointer px-2 py-2 rounded-xl border-2 bg-[#2c2b2b] border-[#4d4b4b] mb-1" v-for="model in chatModels" :key="model.name">
                        {{ model.name }}
                        <span v-if="model.name === modelType"><Icon icon="iconamoon:check-bold" width="1.2em" height="1.2em" /></span>
                    </li>
                </ul>
                <ul>
                    <h2 class="text-[1.175em] mb-1 flex justify-center items-center border-b-2 border-[#363636]">Image</h2>
                    <li @click="handleClick(model.name)" class="flex justify-between cursor-pointer px-2 py-2 rounded-xl border-2 bg-[#2c2b2b] border-[#4d4b4b] mb-1" v-for="model in imageModels" :key="model.name">
                        {{ model.name }}
                        <span v-if="model.name === modelType"><Icon icon="iconamoon:check-bold" width="1.2em" height="1.2em" /></span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>
