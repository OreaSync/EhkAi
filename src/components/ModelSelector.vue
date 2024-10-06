<template>
  <div class="flex justify-center items-center" ref="dropDownAnim">
    <nav>
      <ul class="relative group" @mouseleave="animateDropdownOut">
        <li>
          <a class="cursor-pointer px-4 py-2 rounded-xl border-2 bg-[#111111] border-[#1b1b1bec]" @mouseenter="animateDropdown">
            Models
          </a>
          <ul class="absolute left-0 hidden group-hover:block rounded-md pt-2 w-[180px]" ref="Selector">
            <li v-for="model in models" :key="model.name">
              <a @click="handleClick(model.name, $event)" class="flex justify-between items-center cursor-pointer px-2 py-2 rounded-xl border-2 bg-[#111111] border-[#1b1b1bec] mb-1">
                {{ model.name }}
                <span v-if="model.name === selectedModel"><Icon icon="iconamoon:check-bold" width="1.2em" height="1.2em" /></span>
              </a>
            </li>
          </ul>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import gsap from 'gsap';

const Selector = ref(null);
const dropDownAnim = ref(null);

const models = [
  { name: 'GPT3.5 Turbo' },
  { name: 'GPT-4o Mini'},
  { name: 'GPT-4 Nexra' },
  { name: 'GPT-3.5 Turbo Nexra'},
  { name: 'Command-R+'},
  { name: 'Qwen'},
  { name: 'Blackbox' },
  { name: 'Gemini Pro' },
  { name: 'Gemini' },
];

const selectedModel = ref('GPT3.5 Turbo');
const emit = defineEmits(['selectModel']);

const animateDropdown = () => {
  gsap.to(Selector.value, {
    opacity: 1,
    y: 8,
    duration: 0.3,
    display: 'block',
  });
};

const animateDropdownOut = () => {
  gsap.to(Selector.value, {
    opacity: 0,
    y: 0,
    duration: 0.3,
    onComplete: () => {
      Selector.value.style.display = 'none'; 
    },
  });
};

const animateClick = (element) => {
  gsap.fromTo(
    element,
    { scale: 1 },
    { scale: 0.95, duration: 0.1, yoyo: true, repeat: 1 } 
  );
};

function handleClick(model, event) {
  animateClick(event.currentTarget); 
  selectModel(model);
}

function selectModel(model) {
  selectedModel.value = model;
  emit('selectModel', model);
}

onMounted(() => {
  gsap.fromTo(dropDownAnim.value, { opacity: 0 }, { opacity: 1, y: 12, duration: 1 })
});
</script>
